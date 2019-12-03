//
//  HttpDigger.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "HttpDigger.h"
#if __has_include(<YYCache/YYCache.h>)
#import <YYCache/YYCache.h>
#elif __has_include("YYCache.h")
#import "YYCache.h"
#endif

static HttpDigger *instance = nil;

//YYCache
NSString * const HttpDiggerCache = @"HttpDiggerCache";

@interface HttpDigger ()

@property (nonatomic, strong) YYCache *cache;

@end

@implementation HttpDigger

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

#pragma mark 初始化

- (instancetype)init {
    self = [super init];
    if (self) {
        [self monitorNetworkStatus];
    }
    return self;
}

#pragma mark Cancel Request

- (void)cancelRequest {
    if ([self.networkMgr.tasks count] > 0) {
        [self.networkMgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    }
}

#pragma mark Upload Data

- (void)uploadImageWithUri:(NSString *)uri imageData:(NSData *)imageData success:(Success)success {
    [self uploadImageWithUri:uri imageData:imageData success:success failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:HTTP_ERROR];
    }];
}

- (void)uploadImageWithUri:(NSString *)uri imageData:(NSData *)imageData success:(Success)success failure:(nonnull Failure)failure {
    [self uploadImageWithUri:uri imageData:imageData imageKey:@"image" additionalParameters:nil success:success failure:failure];
}

- (void)uploadImageWithUri:(NSString *)uri imageData:(NSData *)imageData imageKey:(NSString *)imageKey additionalParameters:(nullable NSDictionary *)additionalParameters success:(Success)success {
    [self uploadImageWithUri:uri imageData:imageData imageKey:imageKey additionalParameters:additionalParameters success:success failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:HTTP_ERROR];
    }];
}

- (void)uploadImageWithUri:(NSString *)uri imageData:(NSData *)imageData imageKey:(NSString *)imageKey additionalParameters:(nullable NSDictionary *)additionalParameters success:(Success)success failure:(nonnull Failure)failure {
    [self uploadImageWithUrl:[NSString stringWithFormat:@"%@%@", BASE_URL, uri] imageData:imageData imageKey:imageKey additionalParameters:additionalParameters success:success failure:failure];
}

- (void)uploadImageWithUrl:(NSString *)url imageData:(NSData *)imageData imageKey:(NSString *)imageKey additionalParameters:(nullable NSDictionary *)additionalParameters success:(Success)success failure:(nonnull Failure)failure {
    
//    [self.networkMgr.requestSerializer setValue:[MeInfo sharedInstance].token forHTTPHeaderField:@"XX-Token"];
//    [self.networkMgr.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"XX-Device-Type"];
//    [self.networkMgr.requestSerializer setValue:@"v1" forHTTPHeaderField:@"XX-Api-Version"];
    
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:additionalParameters];
//    [mDict setValue:[MeInfo sharedInstance].user_id forKey:@"user_id"];
    
    NSLog(@"上传图片：%@", url);
    
    [self.networkMgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [mDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *theKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSData *dataValue = nil;
            if ([obj isKindOfClass:[NSArray class]]) {
                dataValue = [NSKeyedArchiver archivedDataWithRootObject:(NSArray *)obj];
            } else if ([obj isKindOfClass:[NSDictionary class]]) {
                dataValue = [NSJSONSerialization dataWithJSONObject:(NSDictionary *)obj options:NSJSONWritingPrettyPrinted error:nil];
            } else if ([obj isKindOfClass:[NSString class]]) {
                dataValue = [(NSString *)obj dataUsingEncoding:NSUTF8StringEncoding];
            } else if ([obj isKindOfClass:[NSData class]]) {
                dataValue = (NSData *)obj;
            } else {
                dataValue = [[NSString stringWithFormat:@"%@", obj] dataUsingEncoding:NSUTF8StringEncoding];
            }
            
            [formData appendPartWithFormData:dataValue name:theKey];
        }];
        
        // Image数据拼接
        if (imageData.length > 0 && imageKey) {
            [formData appendPartWithFormData:imageData name:imageKey];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (success) {
            int code = [responseJson[@"code"] intValue];
            success(code, responseJson[@"msg"], responseJson);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}

//#pragma mark EES Post
//
//- (void)postWithUri:(NSString *)uri parameters:(NSDictionary *)parameters success:(Success)succes failure:(nonnull Failure)failure {
//
//}

#pragma mark Post And Get

// POST
- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(Success)succes {
    [self postWithUri:uri parameters:parameters success:succes failure:^(NSError * _Nonnull error) {
        if (error.code == -1001) {
            [SVProgressHUD showInfoWithStatus:HTTP_TIME_OUT];
        } else if (error.code == -1009) {
            [SVProgressHUD showInfoWithStatus:HTTP_NETWORK_ERROR];
        } else {
            [SVProgressHUD showInfoWithStatus:HTTP_ERROR];
        }
    }];
}

- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(Success)success failure:(Failure)failure {
    [self asyncHttpDiggerWithUri:uri method:@"POST" parameters:parameters authable:YES success:success failure:failure];
}

- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters shouldCache:(BOOL)shouldCache success:(Success)success {
    [self postWithUri:uri parameters:parameters shouldCache:shouldCache success:success failure:^(NSError * _Nonnull error) {
        if (error.code == -1001) {
            [SVProgressHUD showInfoWithStatus:HTTP_TIME_OUT];
        } else if (error.code == -1009) {
            [SVProgressHUD showInfoWithStatus:HTTP_NETWORK_ERROR];
        } else {
            [SVProgressHUD showInfoWithStatus:HTTP_ERROR];
        }
    }];
}

- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters shouldCache:(BOOL)shouldCache success:(Success)success failure:(Failure)failure {
    [self asyncHttpDiggerWithUrl:[NSString stringWithFormat:@"%@%@", BASE_URL, uri] method:@"POST" parameters:parameters authable:YES shouldCache:shouldCache success:success failure:failure];
}

// GET
- (void)getWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(Success)succes {
    [self getWithUri:uri parameters:parameters success:succes failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:HTTP_ERROR];
    }];
}

- (void)getWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(Success)success failure:(Failure)failure {
    [self asyncHttpDiggerWithUri:uri method:@"GET" parameters:parameters authable:YES success:success failure:failure];
}

// BASE
- (void)asyncHttpDiggerWithUri:(NSString *)uri method:(NSString *)method parameters:(NSDictionary *)parameters authable:(BOOL)authable success:(Success)success failure:(Failure)failure {
    [self asyncHttpDiggerWithUrl:[NSString stringWithFormat:@"%@%@", BASE_URL, uri] method:method parameters:parameters authable:authable shouldCache:NO success:success failure:failure];
}

- (void)asyncHttpDiggerWithUri:(NSString *)uri method:(NSString *)method parameters:(NSDictionary *)parameters authable:(BOOL)authable shouldCache:(BOOL)shouldCache success:(Success)success failure:(Failure)failure {
    [self asyncHttpDiggerWithUrl:[NSString stringWithFormat:@"%@%@", BASE_URL, uri] method:method parameters:parameters authable:authable shouldCache:NO success:success failure:failure];
}

- (void)asyncHttpDiggerWithUrl:(NSString *)url method:(NSString *)method parameters:(nullable NSDictionary *)parameters authable:(BOOL)authable success:(Success)success failure:(Failure)failure {
    [self asyncHttpDiggerWithUrl:url method:method parameters:parameters authable:authable shouldCache:YES success:success failure:failure];
}

- (void)asyncHttpDiggerWithUrl:(NSString *)url method:(NSString *)method parameters:(nullable NSDictionary *)parameters authable:(BOOL)authable shouldCache:(BOOL)shouldCache success:(Success)success failure:(Failure)failure {
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    self.networkMgr.requestSerializer = [AFJSONRequestSerializer serializer];
//    [self.networkMgr setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [self.networkMgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.networkMgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    if ([MeInfo sharedInstance].cookie.length > 0) {
        [self.networkMgr.requestSerializer setValue:[MeInfo sharedInstance].cookie forHTTPHeaderField:@"Cookie"];
    }
    
//    NSError *serializationError;
//    NSData *paramerData = [NSJSONSerialization dataWithJSONObject:mDict options:NSJSONWritingPrettyPrinted error:&serializationError];
//    if (serializationError) {
//        NSLog(@"serializationError: %@", serializationError);
//        return;
//    }
    
    
    NSLog(@"网络请求：%@", url);
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@%@", url, (mDict.allKeys.count > 0 ? @"?" : @""), [self generateUrlQueryStringByParameters:mDict]];
//   NSLog(@"cacheKey: %@", cacheKey);
    if (shouldCache) {
        NSData *cacheData = (NSData *)[self.cache objectForKey:cacheKey];
        if (cacheData) {
            id cachedResponseJson = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingAllowFragments error:nil];
            if (success) {
                int code = [cachedResponseJson[@"code"] intValue];
                NSString *msg = [NSString stringWithFormat:@"%@", cachedResponseJson[@"msg"]];
                NSMutableDictionary *responseJson = [NSMutableDictionary dictionaryWithDictionary:cachedResponseJson];
                [responseJson setValue:@(YES) forKey:@"isCachedData"];
                success(code, msg, responseJson);
            }
        }
    }
    
    WS(weakSelf)
    if ([method.uppercaseString isEqualToString:@"POST"]) {
        [self.networkMgr POST:url parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            for (NSHTTPCookie *cookie in [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies) {
                if ([[cookie name] isEqualToString:@".FRAMEWORKFAUTH"]) {
                    [MeInfo sharedInstance].cookie = [cookie value];
                    [weakSelf.networkMgr.requestSerializer setValue:[cookie value] forHTTPHeaderField:@"Cookie"];
                }
                NSLog(@"name: '%@'\n",   [cookie name]);
                NSLog(@"value: '%@'\n",  [cookie value]);
                NSLog(@"domain: '%@'\n", [cookie domain]);
                NSLog(@"path: '%@'\n",   [cookie path]);
            }

            id responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if (success) {
                int code = [responseJson[@"code"] intValue];
                NSString *msg = [NSString stringWithFormat:@"%@", responseJson[@"msg"]];
                success(code, msg, responseJson);

                if (code == 1 && shouldCache) {
                    [weakSelf.cache setObject:responseObject forKey:cacheKey];
                }
            }

            [weakSelf checkLoginIfValidWithResponseJson:responseJson];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
//        [self.networkMgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            [mDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//                NSString *theKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//                NSData *dataValue = nil;
//                if ([obj isKindOfClass:[NSArray class]]) {
//                    dataValue = [NSKeyedArchiver archivedDataWithRootObject:(NSArray *)obj];
//                } else if ([obj isKindOfClass:[NSDictionary class]]) {
//                    dataValue = [NSJSONSerialization dataWithJSONObject:(NSDictionary *)obj options:NSJSONWritingPrettyPrinted error:nil];
//                } else if ([obj isKindOfClass:[NSString class]]) {
//                    dataValue = [(NSString *)obj dataUsingEncoding:NSUTF8StringEncoding];
//                } else if ([obj isKindOfClass:[NSData class]]) {
//                    dataValue = (NSData *)obj;
//                } else {
//                    dataValue = [[NSString stringWithFormat:@"%@", obj] dataUsingEncoding:NSUTF8StringEncoding];
//                }
//
//                [formData appendPartWithFormData:dataValue name:theKey];
//            }];
//        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            id responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//            if (shouldCache) {
//                [weakSelf.cache setObject:responseObject forKey:url];
//            }
//            if (success) {
//                int code = [responseJson[@"code"] intValue];
//                success(code, responseJson[@"msg"], responseJson);
//            }
//            [weakSelf checkLoginIfValidWithResponseJson:responseJson];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            if (failure) {
//                failure(error);
//            }
//        }];
    } else if ([method.uppercaseString isEqualToString:@"GET"]) {
        [self.networkMgr GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            if (success) {
                int code = [responseJson[@"code"] intValue];
                NSString *msg = [NSString stringWithFormat:@"%@", responseJson[@"msg"]];
                success(code, msg, responseJson);
                
                if (code == 1 && shouldCache) {
                    [weakSelf.cache setObject:responseObject forKey:cacheKey];
                }
            }
            
            [weakSelf checkLoginIfValidWithResponseJson:responseJson];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    } else {
        NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
        mRequest.HTTPMethod = method;
        mRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:mDict options:NSJSONWritingPrettyPrinted error:nil];
        
        NSURLSessionDataTask *task = [self.networkMgr dataTaskWithRequest:mRequest uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                if (failure) {
                    failure(error);
                }
            } else {
                id responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                
                if (success) {
                    int code = [responseJson[@"code"] intValue];
                    NSString *msg = [NSString stringWithFormat:@"%@", responseJson[@"msg"]];
                    success(code, msg, responseJson);
                    
                    if (code == 1 && shouldCache) {
                        [weakSelf.cache setObject:responseObject forKey:cacheKey];
                    }
                }
                
                [weakSelf checkLoginIfValidWithResponseJson:responseJson];
            }
        }];
        
        [task resume];
    }
}

#pragma mark private actions

- (void)checkLoginIfValidWithResponseJson:(NSDictionary *)responseJson {
    // 未登录! (token失效)", 10001
    // 异地登陆， 10002
//    int code = [responseJson[@"code"] intValue];
//    if (code == 10001 || code == 10002) {
//        [[MeInfo sharedInstance] clearAccountInfo];
//        [GlobalTool guestLogin];
//
//        [SVProgressHUD showInfoWithStatus:responseJson[@"msg"]];
//        [GlobalTool presentLoginVC];
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOG_STATUS_BECOME_INVALID_NOTIFICATION object:nil];
//    }
}

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

#pragma mark Network Status

- (void)monitorNetworkStatus {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    // 默认有网络
    self.netStatus = NetworkStatusAvailable;
    
    WS(weakSelf)
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变时调用
        if (status == AFNetworkReachabilityStatusReachableViaWiFi ||
            status == AFNetworkReachabilityStatusReachableViaWWAN) {
            if (weakSelf.netStatus == NetworkStatusUnavailable) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NETWORK_STATUS_CHANGED object:nil userInfo:@{@"networkAvailable":@1}];
            }
        } else {
            if (weakSelf.netStatus != NetworkStatusUnavailable) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NETWORK_STATUS_CHANGED object:nil userInfo:@{@"networkAvailable":@0}];
            }
        }
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                NSLog(@"未知网络");
                weakSelf.netStatus = NetworkStatusUnavailable;
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"没有网络");
                weakSelf.netStatus = NetworkStatusUnavailable;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"手机自带网络");
                weakSelf.netStatus = NetworkStatusAvailableCeller;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                NSLog(@"WIFI");
                weakSelf.netStatus = NetworkStatusAvailableWifi;
                break;
            }
        }
    }];
    
    //开始监控
    [manager startMonitoring];
}

#pragma mark getter

- (AFHTTPSessionManager *)networkMgr {
    if (_networkMgr == nil) {
        AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
        AFJSONRequestSerializer* requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setTimeoutInterval:30.0];
        [requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [mgr setRequestSerializer:requestSerializer];
        
        AFHTTPResponseSerializer* responceSerializer = [AFHTTPResponseSerializer serializer];
        responceSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
        
        
        // ssl
//        AFSecurityPolicy* policy = [self customSecurityPolicy];
//        if(nil != policy) {
//            [mgr setSecurityPolicy:policy];
//        }
//        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        mgr.securityPolicy = policy;
//        mgr.securityPolicy.validatesDomainName = NO;
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        mgr.securityPolicy = securityPolicy;
        
        [mgr setResponseSerializer:responceSerializer];
        
        _networkMgr = mgr;
    }
    return _networkMgr;
}


- (YYCache *)cache {
    if (_cache == nil) {
        _cache = [[YYCache alloc] initWithName:HttpDiggerCache];
        _cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
        _cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    }
    return _cache;
}

@end
