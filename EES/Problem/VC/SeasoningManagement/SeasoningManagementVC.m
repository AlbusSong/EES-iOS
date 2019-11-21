//
//  SeasoningManagementVC.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "SeasoningManagementVC.h"
#import "SeasoningManagementFirstCell.h"
#import "SeasoningManagementSecondCell.h"

#import "SeasoningManagementScanCodeVC.h"
#import "SeasoningManagementScanBarcodeVC.h"

@interface SeasoningManagementVC ()

@end

@implementation SeasoningManagementVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"辅料管理";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫描" style:UIBarButtonItemStyleDone target:self action:@selector(tryToScan)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[SeasoningManagementFirstCell class] forCellReuseIdentifier:SeasoningManagementFirstCell.cellIdentifier];
    [self.tableView registerClass:[SeasoningManagementSecondCell class] forCellReuseIdentifier:SeasoningManagementSecondCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnConfirm setTitle:@"上料" forState:UIControlStateNormal];
    [btnConfirm setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
    [self.view addSubview:btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(0);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark actions

- (void)tryToScan {
    WS(weakSelf)
    AlertActionBlock block1 = ^(void) {
        [weakSelf scan:0];
    };
    AlertActionBlock block2 = ^(void) {
        [weakSelf scan:1];
    };
    [GlobalTool popSheetAlertWithTitle:@"选择扫码类型" message:nil optionsStrings:@[@"一维码", @"二维码"] yesActionBlocks:@[block1, block2]];
}

- (void)scan:(NSInteger)index {
    if (index == 0) {
        SeasoningManagementScanCodeVC *vc = [[SeasoningManagementScanCodeVC alloc] init];
        [self pushVC:vc];
    } else {
        SeasoningManagementScanBarcodeVC *vc = [[SeasoningManagementScanBarcodeVC alloc] init];
        [self pushVC:vc];
    }
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    ProblemWholeCheckItemVC *vc = [[ProblemWholeCheckItemVC alloc] init];
//    [self pushVC:vc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
//    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SeasoningManagementFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:SeasoningManagementFirstCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    } else {
        SeasoningManagementSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:SeasoningManagementSecondCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
}

@end
