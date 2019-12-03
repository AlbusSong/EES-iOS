//
//  EESHttpDigger.h
//  EES
//
//  Created by Albus on 2019-12-03.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HttpSuccess) (int code, NSString *message, id responseJson);
typedef void (^HttpFailure) (NSError *error);

@interface EESHttpDigger : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *networkMgr;


+ (instancetype)sharedInstance;


- (void)postWithUri:(NSString *)uri parameters:(NSDictionary *)parameters success:(HttpSuccess)success;
- (void)postWithUri:(NSString *)uri parameters:(nullable NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure;

@end

NS_ASSUME_NONNULL_END
