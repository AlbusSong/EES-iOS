//
//  HttpDigger.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Success) (int code, NSString *msg, id responseJson);
typedef void (^Failure) (NSError *error);

@interface HttpDigger : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *networkMgr;

@property (nonatomic) NetworkStatus netStatus;

+ (instancetype)sharedInstance;


- (void)asyncHttpDiggerWithUrl:(NSString *)url method:(NSString *)method parameters:(nullable NSDictionary *)parameters authable:(BOOL)authable shouldCache:(BOOL)shouldCache success:(Success)success failure:(Failure)failure;
- (void)asyncHttpDiggerWithUrl:(NSString *)url method:(NSString *)method parameters:(nullable NSDictionary *)parameters authable:(BOOL)authable success:(Success)success failure:(Failure)failure;

- (void)asyncHttpDiggerWithUri:(NSString *)uri method:(NSString *)method parameters:(NSDictionary *)parameters authable:(BOOL)authable shouldCache:(BOOL)shouldCache success:(Success)success failure:(Failure)failure;
- (void)asyncHttpDiggerWithUri:(NSString *)uri method:(NSString *)method parameters:(NSDictionary *)parameters authable:(BOOL)authable success:(Success)success failure:(Failure)failure;


- (void)getWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
- (void)getWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(Success)succes;

- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters shouldCache:(BOOL)shouldCache success:(Success)success failure:(Failure)failure;
- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters shouldCache:(BOOL)shouldCache success:(Success)success;
- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(Success)succes;

// 图片上传
- (void)uploadImageWithUri:(NSString *)uri imageData:(NSData *)imageData success:(Success)success;
- (void)uploadImageWithUri:(NSString *)uri imageData:(NSData *)imageData success:(Success)success failure:(nonnull Failure)failure;
- (void)uploadImageWithUri:(NSString *)uri imageData:(NSData *)imageData imageKey:(NSString *)imageKey additionalParameters:(nullable NSDictionary *)additionalParameters success:(Success)success;
- (void)uploadImageWithUri:(NSString *)uri imageData:(NSData *)imageData imageKey:(NSString *)imageKey additionalParameters:(nullable NSDictionary *)additionalParameters success:(Success)success failure:(nonnull Failure)failure;

- (void)uploadImageWithUrl:(NSString *)url imageData:(NSData *)imageData imageKey:(NSString *)imageKey additionalParameters:(nullable NSDictionary *)additionalParameters success:(Success)success failure:(nonnull Failure)failure;

#pragma mark Cancel Request

- (void)cancelRequest;

@end

NS_ASSUME_NONNULL_END
