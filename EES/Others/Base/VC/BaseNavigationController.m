//
//  BaseNavigationController.m
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseNavigationController+SVProgressHud.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *hairlineUnderNavBar;

@end

@implementation BaseNavigationController

//- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
//    self = [super initWithNavigationBarClass:[ASNavigationBar class] toolbarClass:nil];
//    if (self) {
//        [self setViewControllers:@[rootViewController]];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self customNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setSVProgressHudStyle];
}

- (void)customNavigationBar {
    self.navigationBar.tintColor = HexColor(@"ffffff");
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = HexColor(@"4897ed");
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
}

#pragma mark UINavigationControllerDelegate

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark 去除导航栏底部黑线

- (void)makeHairLineUnderNavHidden:(BOOL)yesToHide animated:(BOOL)animated {
    return;
    if (IS_IOS12_OR_LATER) {
        if (yesToHide) {
            [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:[[UIImage alloc] init]];
        } else {
            [self.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:nil];
        }
        
        return;
    }
    
    if (yesToHide) {
        if (!self.hairlineUnderNavBar.hidden) {
            self.hairlineUnderNavBar.alpha = 1.0;
            [UIView animateWithDuration:(animated ? 0.2 : 0) animations:^(void) {
                self.hairlineUnderNavBar.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.hairlineUnderNavBar.hidden = YES;
            }];
        }
    }
    else {
        if (self.hairlineUnderNavBar.hidden) {
            self.hairlineUnderNavBar.hidden = NO;
            self.hairlineUnderNavBar.alpha = 0.0;
            [UIView animateWithDuration:(animated ? 0.2 : 0) animations:^(void) {
                self.hairlineUnderNavBar.alpha = 1.0;
            }];
        }
    }
}

- (void)makeHairLineUnderNavHidden:(BOOL)yesToHide {
    [self makeHairLineUnderNavHidden:yesToHide animated:NO];
}

//获取导航栏黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    unsigned  int count = 0;
    Ivar *members = class_copyIvarList([UINavigationBar class], &count);
    for (int i = 0; i < count; i++)    {
        Ivar var = members[i];
        const char *memberAddress = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"address = %s ; type = %s", memberAddress,memberType);
    }
    //  view.clipsToBounds = YES;
    //    NSLog(@"findHairlineImageViewUnder: %@,\n %@", view, view.subviews);
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView* imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    
    return nil;
}

#pragma mark StatusBar

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

@end
