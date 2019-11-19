//
//  GlobalTool.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "GlobalTool.h"
#import <CommonCrypto/CommonDigest.h>

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

#pragma mark color

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*)contentsFileStyleImageOfName:(NSString *)imageName {
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], imageName]];
}

+ (NSString *)md5String:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end
