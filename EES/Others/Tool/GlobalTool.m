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

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    return [dateFormatter dateFromString:dateString];
}

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

#pragma mark Alert Pop

+ (void)popSheetAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message optionsStrings:(NSArray <NSString *> *)optionStrings yesActionBlocks:(NSArray <AlertActionBlock> *)actionBlocks {
    [self popSheetAlertOnVC:[UIApplication sharedApplication].delegate.window.rootViewController title:title message:message cancelStr:@"Cancel" optionsStrings:optionStrings yesActionBlocks:actionBlocks];
}

+ (void)popSheetAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message optionsStrings:(NSArray <NSString *> *)optionStrings yesActionBlocks:(NSArray <AlertActionBlock> *)actionBlocks {
    [self popSheetAlertOnVC:vc title:title message:message cancelStr:@"Cancel" optionsStrings:optionStrings yesActionBlocks:actionBlocks];
}

+ (void)popSheetAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message cancelStr:(NSString *)cancelStr optionsStrings:(NSArray <NSString *> *)optionStrings yesActionBlocks:(NSArray <AlertActionBlock> *)actionBlocks {
    if (optionStrings.count == 0 || actionBlocks.count == 0) {
        return;
    }
    
    UIAlertController *sheetAlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *sheetAlertActionOfNo = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:nil];
    [sheetAlertController addAction:sheetAlertActionOfNo];
    
    NSInteger length = (optionStrings.count >= actionBlocks.count ? optionStrings.count : actionBlocks.count);
    for (int i = 0; i < length; i++) {
        NSString *optionString = optionStrings[i];
        AlertActionBlock actionBlock = actionBlocks[i];
        UIAlertAction *sheetAlertAction = [UIAlertAction actionWithTitle:optionString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actionBlock) {
                actionBlock();
            }
        }];
        [sheetAlertController addAction:sheetAlertAction];
    }
    
    [vc presentViewController:sheetAlertController animated:YES completion:nil];
}

+ (void)popAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock {
    [self popAlertOnVC:[UIApplication sharedApplication].delegate.window.rootViewController title:title message:message yesStr:yesStr noStr:@"取消" yesActionBlock:yesActionBlock];
}

+ (void)popAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock {
    [self popAlertOnVC:vc title:title message:message yesStr:yesStr noStr:@"取消" yesActionBlock:yesActionBlock];
}

+ (void)popAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr noStr:(NSString *)noStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock {
    [self popAlertOnVC:vc title:title message:message yesStr:yesStr noStr:noStr yesActionBlock:yesActionBlock noActionBlock:nil];
}

+ (void)popAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr noStr:(NSString *)noStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock noActionBlock:(nonnull AlertActionBlock)noActionBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertActionOfNo = [UIAlertAction actionWithTitle:noStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (noActionBlock) {
            noActionBlock();
        }
    }];
    
    UIAlertAction *alertActionOfYes = [UIAlertAction actionWithTitle:yesStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (yesActionBlock) {
            yesActionBlock();
        }
    }];
    
    [alertController addAction:alertActionOfNo];
    [alertController addAction:alertActionOfYes];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)popSingleActionAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr yesActionBlock:(nullable AlertActionBlock)yesActionBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertActionOfYes = [UIAlertAction actionWithTitle:yesStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (yesActionBlock) {
            yesActionBlock();
        }
    }];
    
    [alertController addAction:alertActionOfYes];
    
    [vc presentViewController:alertController animated:YES completion:nil];
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

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp) {
        return aImage;
    }
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
