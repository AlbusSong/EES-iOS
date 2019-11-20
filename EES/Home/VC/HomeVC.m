//
//  HomeVC.m
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "HomeVC.h"
#import "HomeMenuVC.h"
#import "HomeFunctionModulesVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"智无形云MES";
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"M" style:UIBarButtonItemStyleDone target:self action:@selector(gotoMenu)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"S" style:UIBarButtonItemStyleDone target:self action:@selector(gotoSearch)];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    if (@available(iOS 11.0, *)) {
//        self.navigationController.navigationBar.prefersLargeTitles = YES;
//    } else {
//
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServer {
    [[HttpDigger sharedInstance] postWithUri:LOGIN parameters:@{@"UserName":@"zq", @"Password":@"123456"} success:^(int code, NSString * _Nonnull msg, id  _Nonnull responseJson) {
        NSLog(@"LOGIN responseJson: %@", responseJson);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"LOGIN error: %@", error);
    }];
}

#pragma mark actions

- (void)gotoMenu {
    HomeMenuVC *vcOfMenu = [[HomeMenuVC alloc] init];
    WS(weakSelf)
    vcOfMenu.blockOfGoingToFunctions = ^{
        HomeFunctionModulesVC *vc = [[HomeFunctionModulesVC alloc] init];
        [weakSelf pushVC:vc];
    };
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vcOfMenu];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    nav.navigationBar.hidden = YES;
    nav.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [self presentViewController:nav animated:NO completion:nil];
}

- (void)gotoSearch {
    
}

@end
