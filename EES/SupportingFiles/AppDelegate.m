//
//  AppDelegate.m
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"

#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.blackColor;
    
    HomeVC *vcOfHome = [[HomeVC alloc] init];
    BaseNavigationController *rootVC = [[BaseNavigationController alloc] initWithRootViewController:vcOfHome];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    [self configSVGProgressHUD];
    
    [self initThirdPartyService];
    
    [MeInfo sharedInstance].shouldRememberMe = YES;
    
    return YES;
}

#pragma mark 初始化第三方

- (void)configSVGProgressHUD {
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor: [[UIColor blackColor] colorWithAlphaComponent:0.8]];
}

- (void)initThirdPartyService {
    // IQKeyboardManager
    [IQKeyboardManager sharedManager].enable = YES;
}

//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
