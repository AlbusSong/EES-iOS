//
//  NSString+JSON.h
//  EES
//
//  Created by Albus on 2019-11-28.
//  Copyright © 2019 Zivos. All rights reserved.
//




#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JSON)

- (NSDictionary *)toDictionary;
- (NSArray *)toArray;

@end

NS_ASSUME_NONNULL_END
