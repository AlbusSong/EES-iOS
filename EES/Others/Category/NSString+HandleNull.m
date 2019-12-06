//
//  NSString+HandleNull.m
//  EES
//
//  Created by Albus on 2019-12-06.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "NSString+HandleNull.h"


@implementation NSString (HandleNull)

+ (NSString *)avoidNull:(NSString *)string {
    if (string == nil) {
        return @"";
    }
    
    if (string.length == 0) {
        return @"";
    }
    
    if ([string isEqualToString:@"null"] ||
        [string isEqualToString:@"<null>"] ||
        [string isEqualToString:@"(null)"]) {
        return @"";
    }
    
    return string;
}

- (NSString *)avoidNull {
    if (self.length == 0) {
        return @"";
    }
    
    if ([self isEqualToString:@"null"] ||
        [self isEqualToString:@"<null>"] ||
        [self isEqualToString:@"(null)"]) {
        return @"";
    }
    
    return self;
}

@end
