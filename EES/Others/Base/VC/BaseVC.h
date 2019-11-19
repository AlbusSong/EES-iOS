//
//  BaseVC.h
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController

@property (nonatomic, strong) UIView *navigationView;



- (void)back;
- (void)backAnimated:(BOOL)animated;

// 初始化一些东西
- (void)initSubviews;

- (void)loadData;
- (void)getDataFromServer;

- (void)setNavigationBottomLineColor:(UIColor *)color;
- (void)showNavigationBottomLine:(BOOL)shouldShow;

- (void)setNavigationViewBackgroundColor:(UIColor *)color shouldShowBottomLine:(BOOL)shouldShowBottomLine;
- (void)setNavigationViewBackgroundColor:(UIColor *)color;

- (void)hideNavigationView:(BOOL)shouldHide;

//- (void)loadData;
- (void)pushVC:(UIViewController *)nextVC animated:(BOOL)animated;
- (void)pushVC:(UIViewController *)nextVC;

@end

NS_ASSUME_NONNULL_END

