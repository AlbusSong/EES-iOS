//
//  NSString+HandleNull.h
//  EES
//
//  Created by Albus on 2019-12-06.
//  Copyright © 2019 Zivos. All rights reserved.
//




#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HandleNull)

+ (NSString *)avoidNull:(NSString *)string;

- (NSString *)avoidNull;

@end

NS_ASSUME_NONNULL_END
