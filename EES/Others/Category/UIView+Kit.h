//
//  UIView+Kit.h
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Kit)

/*UIView Frame*/
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign, readonly) CGPoint boundsCenter;
@property (nonatomic, assign, readonly) CGFloat boundsCenterX;
@property (nonatomic, assign, readonly) CGFloat boundsCenterY;

@property (nonatomic, assign) CGPoint   origin;
@property (nonatomic, assign) CGSize    size;

@end

NS_ASSUME_NONNULL_END
