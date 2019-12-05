//
//  MeInfo.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeInfo : NSObject

+ (instancetype _Nullable )sharedInstance;


@property (nonatomic) BOOL isLogined;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *password;

@property (nonatomic) BOOL shouldRememberMe;

@property (nonatomic, copy) NSString *cookie;

@end

NS_ASSUME_NONNULL_END
