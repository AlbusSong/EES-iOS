//
//  NSString+Util.h
//  EES
//
//  Created by Albus on 2019-12-08.
//  Copyright © 2019 Zivos. All rights reserved.
//




#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Util)

+ (BOOL)isAvailableString:(NSString *)string;

- (instancetype)trim;

@end

NS_ASSUME_NONNULL_END
