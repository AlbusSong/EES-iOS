//
//  GlobalTool.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalTool : NSObject

+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text fontSize:(CGFloat)fontSize;
+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font;
+ (CGSize)sizeFitsWithSize:(CGSize)size attributeText:(NSAttributedString *)attributeText;


+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage*)contentsFileStyleImageOfName:(NSString *)imageName;

+ (NSString *)md5String:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
