//
//  LoginTimeoutVC.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "LoginTimeoutVC.h"
#import "LoginTimeoutHintCell.h"

#import "LoginVC.h"


@interface LoginTimeoutVC ()

@end

@implementation LoginTimeoutVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"登陆超时";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[LoginTimeoutHintCell class] forCellReuseIdentifier:LoginTimeoutHintCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
    UIButton *btnRelogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRelogin.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btnRelogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRelogin setTitle:@"重新登陆" forState:UIControlStateNormal];
    [btnRelogin setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
    [btnRelogin addTarget:self action:@selector(tryToRelogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRelogin];
    [btnRelogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
}

#pragma mark gestures

- (void)tryToRelogin {
    LoginVC *vcOfLogin = [[LoginVC alloc] init];
    WS(weakSelf)
    [self presentViewController:vcOfLogin animated:YES completion:^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoginTimeoutHintCell *cell = [tableView dequeueReusableCellWithIdentifier:LoginTimeoutHintCell.cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
