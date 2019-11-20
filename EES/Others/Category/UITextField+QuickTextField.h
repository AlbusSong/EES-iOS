//
//  UITextField+QuickTextField.h
//  EES
//
//  Created by Albus on 20/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (QuickTextField)

+ (instancetype)quickTextFieldWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr placeholderColorHexStr:(NSString *)placeholderColorHexStr;
+ (instancetype)quickTextFieldWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColorHexStr:(NSString *)textColorHexStr placeholderColorHexStr:(NSString *)placeholderColorHexStr;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColorHexStr:(NSString *)textColorHexStr;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholderColor:(UIColor *)placeholderColor placeholder:(NSString *)placeholder;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholderColor:(UIColor *)placeholderColor;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;
+ (instancetype)quickTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment placeholder:(nullable NSString *)placeholder placeholderFont:(UIFont *)placeholderFont placeholderColor:(UIColor *)placeholderColor;

@end

NS_ASSUME_NONNULL_END
