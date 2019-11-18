//
//  UIColor+HexString.h
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexString)

/**
 * 16进制颜色字符串转为UIColor
 */
+(UIColor *)colorWithHexString: (NSString *) stringToConvert;

/**
 *  16进制颜色(html颜色值)字符串转为UIColor
 *
 *  @param hexString 16进制颜色
 *  @param alpha           透明度
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
