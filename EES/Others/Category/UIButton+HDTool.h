//
//  UIButton+HDTool.h
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonImagePosition) {
    ButtonImagePositionLeft = 0,              //图片在左，文字在右，默认
    ButtonImagePositionRight = 1,             //图片在右，文字在左
    ButtonImagePositionTop = 2,               //图片在上，文字在下
    ButtonImagePositionBottom = 3,            //图片在下，文字在上
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HDTool)
/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(ButtonImagePosition)postion spacing:(CGFloat)spacing;
- (void)setSelectImagePosition:(ButtonImagePosition)postion spacing:(CGFloat)spacing;

//“扩大”btn的事件响应区域
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

/** 改变UIButton的文本的 两种以上颜色及字体 保存的是所有UIFont的大小 是一个数字 */
+ (void)changeTextBtn:(UIButton *)myBtn

          stringArray:(NSArray *)strArray

           colorArray:(NSArray *)colorArray

            fontArray:(NSArray *)fontArray;

/** 改变UIButton的文本的 两种以上颜色及字体  带状态的 fontArray 保存的是所有UIFont */
+ (void)changeTextBtn:(UIButton *)myBtn

          stringArray:(NSArray *)strArray

           colorArray:(NSArray *)colorArray

            fontArray:(NSArray *)fontArray forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
