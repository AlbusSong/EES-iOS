//
//  GlobalTool.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "GlobalTool.h"

static UILabel *txtForSizeFitting = nil;

@implementation GlobalTool

#pragma mark 计算文本大小

+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text fontSize:(CGFloat)fontSize {
    return [self sizeFitsWithSize:size text:text font:[UIFont systemFontOfSize:fontSize]];
}

+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font {
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:(text ? text : @"") attributes:@{NSFontAttributeName:font}];
    return [self sizeFitsWithSize:size attributeText:attri];
}

+ (CGSize)sizeFitsWithSize:(CGSize)size attributeText:(NSAttributedString *)attributeText {
    if (txtForSizeFitting == nil) {
        txtForSizeFitting = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"ffffff") parentView:nil];
    }
    txtForSizeFitting.attributedText = attributeText;
    return [txtForSizeFitting sizeThatFits:size];
}

@end
