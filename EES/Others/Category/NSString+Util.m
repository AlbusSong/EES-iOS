//
//  NSString+Util.m
//  EES
//
//  Created by Albus on 2019-12-08.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "NSString+Util.h"



@implementation NSString (Util)

+ (BOOL)isAvailableString:(NSString *)string {
    if ([string isKindOfClass:[NSString class]] == NO) {
        return NO;
    }
    
    if ([string isEqualToString:@""]) {
        return NO;
    }
    
    if ([string isEqualToString:@"null"] ||
        [string isEqualToString:@"<null>"] ||
        [string isEqualToString:@"(null)"]) {
        return NO;
    }
    
    return YES;
}

// 将首尾的空格去掉
- (instancetype)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
