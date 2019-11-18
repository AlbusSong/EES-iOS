//
//  BaseNavigationController+SVProgressHud.m
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseNavigationController+SVProgressHud.h"


@implementation BaseNavigationController (SVProgressHud)

- (void)setSVProgressHudStyle {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setSuccessImage:nil];
    [SVProgressHUD setErrorImage:nil];
    [SVProgressHUD setInfoImage:nil];
//    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(UIRectEdgeRight, UIRectEdgeBottom)];
    [SVProgressHUD setAnimationDelay:2.0];
    [SVProgressHUD setHapticsEnabled:YES];
}

@end
