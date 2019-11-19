//
//  HomeMenuVC.m
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "HomeMenuVC.h"
#import "HomeMenuUserCell.h"
#import "HomeMenuFunctionCell.h"

@interface HomeMenuVC () <UIGestureRecognizerDelegate>

@end

@implementation HomeMenuVC

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClicked:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    [self.tableView registerClass:[HomeMenuUserCell class] forCellReuseIdentifier:HomeMenuUserCell.cellIdentifier];
    [self.tableView registerClass:[HomeMenuFunctionCell class] forCellReuseIdentifier:HomeMenuFunctionCell.cellIdentifier];
    self.tableView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self showAnimated];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    if (indexPath.section == 1) {
        
    } else if (indexPath.section == 2) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.view);
                make.right.equalTo(self.view.mas_left);
                make.width.mas_equalTo(ScreenW*2/3.0);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (self.blockOfGoingToFunctions) {
                self.blockOfGoingToFunctions();
            }
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    } else {
        return 35;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    } else if (section == 1) {
        return 20;
    } else {
        return 55;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 2) {
        return nil;
    }
    
    UIView *headerView = [[UIView alloc] init];
    
    UILabel *txtOfTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:11] textColor:HexColor(@"999999") parentView:headerView];
    [txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-5);
        make.height.mas_equalTo(15);
        make.left.offset(15);
    }];
    txtOfTitle.text = @"功能模块";
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HomeMenuUserCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeMenuUserCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    } else {
        HomeMenuFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeMenuFunctionCell.cellIdentifier forIndexPath:indexPath];
        
        if (indexPath.section == 1) {
            [cell resetSubviewsWithTitle:@"注销"];
        } else {
            [cell resetSubviewsWithTitle:@"设备管理"];
        }
        
        return cell;
    }
}

#pragma mark actions

- (void)showAnimated {
    self.tableView.hidden = NO;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.right.equalTo(self.view.mas_left);
        make.width.mas_equalTo(ScreenW*2/3.0);
    }];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view);
            make.left.equalTo(self.view.mas_left);
            make.width.mas_equalTo(ScreenW*2/3.0);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideAnimated {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view);
            make.right.equalTo(self.view.mas_left);
            make.width.mas_equalTo(ScreenW*2/3.0);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark Gestures

- (void)backgroundClicked:(UITapGestureRecognizer *)sender {
    [self hideAnimated];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }
    
    return YES;
}

@end
