//
//  MeInfo.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "MeInfo.h"

static MeInfo *instance = nil;

@implementation MeInfo

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSomeVars];
    }
    return self;
}

- (void)initSomeVars {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.isLogined = [userDefaults boolForKey:@"isLogined"];
    self.username = [userDefaults objectForKey:@"username"];
    self.password = [userDefaults objectForKey:@"password"];
    self.shouldRememberMe = [userDefaults boolForKey:@"shouldRememberMe"];
    self.cookie = [userDefaults objectForKey:@"cookie"];
}

#pragma mark setter

- (void)setIsLogined:(BOOL)isLogined {
    _isLogined = isLogined;
    
    [[NSUserDefaults standardUserDefaults] setBool:isLogined forKey:@"isLogined"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUsername:(NSString *)username {
    _username = username;
    
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setPassword:(NSString *)password {
    _password = password;
    
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShouldRememberMe:(BOOL)shouldRememberMe {
    if (_shouldRememberMe == shouldRememberMe) {
        return;
    }
    
    _shouldRememberMe = shouldRememberMe;
    [[NSUserDefaults standardUserDefaults] setBool:shouldRememberMe forKey:@"shouldRememberMe"];
    
    if (shouldRememberMe == NO) {
        self.username = @"";
        self.password = @"";
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setCookie:(NSString *)cookie {
    _cookie = cookie;

    [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"cookie"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
