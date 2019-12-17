//
//  GlobalTool.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AlertActionBlock) (void);

@interface GlobalTool : NSObject

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;

+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text fontSize:(CGFloat)fontSize;
+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font;
+ (CGSize)sizeFitsWithSize:(CGSize)size attributeText:(NSAttributedString *)attributeText;


+ (void)popSheetAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message optionsStrings:(NSArray <NSString *> *)optionStrings yesActionBlocks:(NSArray <AlertActionBlock> *)actionBlocks;
+ (void)popSheetAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message optionsStrings:(NSArray <NSString *> *)optionStrings yesActionBlocks:(NSArray <AlertActionBlock> *)actionBlocks;
+ (void)popSheetAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message cancelStr:(NSString *)cancelStr optionsStrings:(NSArray <NSString *> *)optionStrings yesActionBlocks:(NSArray <AlertActionBlock> *)actionBlocks;
+ (void)popAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock;
+ (void)popAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr noStr:(NSString *)noStr yesActionBlock:(AlertActionBlock)yesActionBlock;
+ (void)popAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock;
+ (void)popAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr noStr:(NSString *)noStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock noActionBlock:(nonnull AlertActionBlock)noActionBlock;
+ (void)popSingleActionAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr yesActionBlock:(nullable AlertActionBlock)yesActionBlock;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage*)contentsFileStyleImageOfName:(NSString *)imageName;

+ (NSString *)md5String:(NSString *)string;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end

NS_ASSUME_NONNULL_END
