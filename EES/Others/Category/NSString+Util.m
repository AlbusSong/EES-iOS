//
//  NSString+Util.m
//  EES
//
//  Created by Albus on 2019-12-08.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "NSString+Util.h"



@implementation NSString (Util)

// 将首尾的空格去掉
- (instancetype)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
