//
//  UILabel+QuickLabel.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "UILabel+QuickLabel.h"


@implementation UILabel (QuickLabel)

+ (instancetype)quickLabelWithFontSize:(CGFloat)fontSize textColorHexStr:(NSString *)textColorHexStr parentView:(nullable UIView *)parentView {
    return [self quickLabelWithFont:[UIFont systemFontOfSize:fontSize] textColor:[UIColor colorWithHexString:textColorHexStr] parentView:parentView];
}

+ (instancetype)quickLabelWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor parentView:(nullable UIView *)parentView {
    return [self quickLabelWithFont:[UIFont systemFontOfSize:fontSize] textColor:textColor parentView:parentView];
}

+ (instancetype)quickLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor parentView:(nullable UIView *)parentView {
    UILabel *label = [[self alloc] init];
    label.textColor = textColor;
    label.font = font;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    [parentView addSubview:label];
    
    return label;
}

@end
