//
//  EESHttpDigger.m
//  EES
//
//  Created by Albus on 2019-12-03.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "EESHttpDigger.h"
//#if __has_include(<YYCache/YYCache.h>)
//#import <YYCache/YYCache.h>
//#elif __has_include("YYCache.h")
//#import "YYCache.h"
//#endif
#import <YYCache/YYCache.h>
#import "LoginTimeoutVC.h"

//YYCache
NSString * const EESHttpDiggerCache = @"EESHttpDiggerCache";

static EESHttpDigger *instance = nil;

@interface EESHttpDigger ()

@property (nonatomic, strong) YYCache *cache;

@end

@implementation EESHttpDigger

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(HttpSuccess)success {
    [self postWithUri:uri parameters:parameters shouldCache:NO success:success failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:HTTP_ERROR];
    }];
}

- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure {
    [self postWithUri:uri parameters:parameters shouldCache:NO success:success failure:failure];
}

- (void)postWithUri:(NSString *)uri parameters:(NSDictionary *)parameters shouldCache:(BOOL)shouldCache success:(nonnull HttpSuccess)success {
    [self postWithUri:uri parameters:parameters shouldCache:shouldCache success:success failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:HTTP_ERROR];
    }];
}

- (void)postWithUri:(NSString *)uri parameters:(NSDictionary *)parameters shouldCache:(BOOL)shouldCache success:(HttpSuccess)success failure:(HttpFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, uri];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    
    NSLog(@"NetworkRequest Url：%@", url);
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@%@", url, (mDict.allKeys.count > 0 ? @"?" : @""), [self generateUrlQueryStringByParameters:mDict]];
    NSLog(@"cacheKey: %@", cacheKey);
    if (shouldCache) {
        NSData *cacheData = (NSData *)[self.cache objectForKey:cacheKey];
        if (cacheData) {
            id cachedResponseJson = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingAllowFragments error:nil];
            
            if (success) {
                int code = [cachedResponseJson[@"Success"] intValue];
                NSString *msg = [NSString stringWithFormat:@"%@", cachedResponseJson[@"Message"]];
                NSMutableDictionary *responseJson = [NSMutableDictionary dictionaryWithDictionary:cachedResponseJson];
                [responseJson setValue:@(YES) forKey:@"isCachedData"];
                success(code, msg, responseJson);
            }
        }
    }
    
    WS(weakSelf)
    [self.networkMgr POST:url parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([uri isEqualToString:HOME_FUNCTION_MODULES] == NO &&
            [self checkIfLoginAvailableBy:responseJson] == NO) {
            return ;
        }
        
        if (success) {
            int code = [responseJson[@"Success"] intValue];
            success(code, responseJson[@"Message"], responseJson);
        }
        
        if (shouldCache) {
            [weakSelf.cache setObject:responseObject forKey:cacheKey];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark 登陆状态检测

- (BOOL)checkIfLoginAvailableBy:(NSDictionary *)responseJson {
    NSLog(@"checkIfLoginAvailableBy: %@", responseJson);
    int code = [responseJson[@"Success"] intValue];
    NSString *Message = [responseJson objectForKey:@"Message"];
    if (code == 0 && [Message isEqualToString:@"ErrorCodeSys001:登录超时"]) {
        [MeInfo sharedInstance].isLogined = NO;
        
        LoginTimeoutVC *vcOfTimeout = [[LoginTimeoutVC alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vcOfTimeout];
        nav.navigationBar.hidden = YES;
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [ROOT_VC presentViewController:nav animated:YES completion:nil];
        
        return NO;
    }
    
    return YES;
}

#pragma mark private methods

- (NSString *)generateUrlQueryStringByParameters:(NSDictionary *)parameters {
    if (!parameters) {
        return @"";
    }
    
    NSMutableArray *parts = [NSMutableArray array];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //接收key
        NSString *finalKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //接收值
        NSString *finalValue = [[NSString stringWithFormat:@"%@", obj] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *part =[NSString stringWithFormat:@"%@=%@",finalKey,finalValue];
        
        if (![finalKey isEqualToString:@"image"]) {
            [parts addObject:part];
        }
    }];
    
    NSString *queryString = [parts componentsJoinedByString:@"&"];
    queryString = queryString ? [NSString stringWithFormat:@"%@", queryString] : @"";
    
    return queryString;
}

#pragma mark getter

- (AFHTTPSessionManager *)networkMgr {
    if (_networkMgr == nil) {
        _networkMgr = [AFHTTPSessionManager manager];
        
        AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
        AFJSONRequestSerializer* requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setTimeoutInterval:30.0];
        [requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        //        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [_networkMgr setRequestSerializer:requestSerializer];
        
        AFHTTPResponseSerializer* responceSerializer = [AFHTTPResponseSerializer serializer];
        //        responceSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
        responceSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", nil];
        [_networkMgr setResponseSerializer:responceSerializer];
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        mgr.securityPolicy = securityPolicy;
    }
    return _networkMgr;
}

- (YYCache *)cache {
    if (_cache == nil) {
        _cache = [[YYCache alloc] initWithName:EESHttpDiggerCache];
        _cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
        _cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    }
    return _cache;
}

@end
