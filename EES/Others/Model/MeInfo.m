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
    
    self.shouldRememberMe = [userDefaults boolForKey:@"shouldRememberMe"];
    self.cookie = [userDefaults objectForKey:@"cookie"];
}

#pragma mark setter

- (void)setShouldRememberMe:(BOOL)shouldRememberMe {
    if (_shouldRememberMe == shouldRememberMe) {
        return;
    }
    
    _shouldRememberMe = shouldRememberMe;
    [[NSUserDefaults standardUserDefaults] setBool:shouldRememberMe forKey:@"shouldRememberMe"];
    
    if (shouldRememberMe == NO) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cookie"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setCookie:(NSString *)cookie {
    _cookie = cookie;
    
    [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"cookie"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    if (_shouldRememberMe) {
//
//    }
}

@end
