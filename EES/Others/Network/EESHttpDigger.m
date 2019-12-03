//
//  EESHttpDigger.m
//  EES
//
//  Created by Albus on 2019-12-03.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "EESHttpDigger.h"

static EESHttpDigger *instance = nil;

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

- (void)postWithUri:(NSString *)uri parameters:(NSDictionary *)parameters success:(HttpSuccess)success {
    [self postWithUri:uri parameters:parameters success:success failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:HTTP_ERROR];
    }];
}

- (void)postWithUri:(NSString *)uri parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, uri];
    
//    WS(weakSelf)
    [self.networkMgr POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
//        for (NSHTTPCookie *cookie in [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies) {
//            if ([[cookie name] isEqualToString:@".FRAMEWORKFAUTH"] &&
//                [uri isEqualToString:LOGIN]) {
//                [MeInfo sharedInstance].cookie = [cookie value];
//                [weakSelf.networkMgr.requestSerializer setValue:[cookie value] forHTTPHeaderField:@"Cookie"];
//
//            }
//            NSLog(@"name: '%@'\n",   [cookie name]);
//            NSLog(@"value: '%@'\n",  [cookie value]);
//            NSLog(@"domain: '%@'\n", [cookie domain]);
//            NSLog(@"path: '%@'\n",   [cookie path]);
//        }
        
        if (success) {
            int code = [responseJson[@"Success"] intValue];
            success(code, responseJson[@"Message"], responseJson);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
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

@end
