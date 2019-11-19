//
//  UILabel+QuickLabel.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (QuickLabel)

+ (instancetype)quickLabelWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr parentView:(nullable UIView *)parentView;
+ (instancetype)quickLabelWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor parentView:(nullable UIView *)parentView;
+ (instancetype)quickLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor parentView:(nullable UIView *)parentView;

@end

NS_ASSUME_NONNULL_END
