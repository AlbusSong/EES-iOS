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

@end
