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
#import "LoginVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"智无形云MES";
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_navigationbar_action_menu"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoMenu)];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"S" style:UIBarButtonItemStyleDone target:self action:@selector(gotoSearch)];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged:) name:@"loginStatusChanged" object:nil];
    }
    return self;
}

#pragma mark notification

- (void)loginStatusChanged:(NSNotification *)notif {
    NSLog(@"loginStatusChanged");
    
    [self getDataFromServer];
}

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HexColor(@"f0eff5");
    
    [self initSubviews];
    
    [self getDataFromServer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([MeInfo sharedInstance].isLogined == NO) {
        LoginVC *vcOfLogin = [[LoginVC alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vcOfLogin];
        nav.navigationBar.hidden = YES;
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark init subviews

- (void)initSubviews {
    UIImageView *imgvOfCompanyLogo = [[UIImageView alloc] init];
    imgvOfCompanyLogo.image = [UIImage imageNamed:@"Home-CompanyLogo"];
    imgvOfCompanyLogo.contentMode = UIViewContentModeScaleAspectFit;
    imgvOfCompanyLogo.clipsToBounds = YES;
    [self.view addSubview:imgvOfCompanyLogo];
    [imgvOfCompanyLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-30);
        CGFloat widthOfImgv = ScreenW - 50*2;
        make.width.mas_equalTo(widthOfImgv);
        make.height.mas_equalTo(widthOfImgv * imgvOfCompanyLogo.image.size.height / imgvOfCompanyLogo.image.size.width);
    }];
}

#pragma mark network

- (void)getDataFromServer {
    if ([MeInfo sharedInstance].username.length == 0 ||
        [MeInfo sharedInstance].password.length == 0) {
        return;
    }
    
    [[EESHttpDigger sharedInstance] postWithUri:LOGIN parameters:@{@"UserName":[MeInfo sharedInstance].username, @"Password":[MeInfo sharedInstance].password} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
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
