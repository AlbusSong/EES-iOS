//
//  ProblemMaintenancePlanDetailVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenancePlanDetailVC.h"
#import "ProblemMaintenancePlanDetailTitleCell.h"
#import "ProblemMaintenancePlanDetailInfoCell.h"

#import "MaintenancePlanItemModel.h"
#import "MaintenancePlanDetailModel.h"

@interface ProblemMaintenancePlanDetailVC ()

@property (nonatomic, strong) MaintenancePlanDetailModel *detailData;

@end

@implementation ProblemMaintenancePlanDetailVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"计划维修详情";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[ProblemMaintenancePlanDetailTitleCell class] forCellReuseIdentifier:ProblemMaintenancePlanDetailTitleCell.cellIdentifier];
    [self.tableView registerClass:[ProblemMaintenancePlanDetailInfoCell class] forCellReuseIdentifier:ProblemMaintenancePlanDetailInfoCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
    NSArray *arrOfFunction = @[@"开始", @"结束"];
    CGFloat btnWidth = floorf((ScreenW - 4*1)/2.0);
    for (int i = 0; i < arrOfFunction.count; i++) {
        UIButton *btnFunction = [UIButton buttonWithType:UIButtonTypeCustom];
        btnFunction.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [btnFunction setTitle:arrOfFunction[i] forState:UIControlStateNormal];
        [btnFunction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnFunction setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal
         ];
        btnFunction.tag = 10000 + i;
        [btnFunction addTarget:self action:@selector(btnFunctionClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnFunction];
        [btnFunction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(btnWidth);
            make.left.offset(i*(btnWidth+1));
            if (i == 1) {
                make.right.equalTo(self.view);
            }
        }];
    }
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_PLAN_GET_ITEM_DETAIL parameters:@{@"workOrderNo":self.data.WorkOrderNo} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD dismiss];
        NSLog(@"MAINTENANCE_PLAN_GET_ITEM_DETAIL: %@", responseJson);
        weakSelf.detailData = [MaintenancePlanDetailModel mj_objectWithKeyValues:responseJson[@"Extend"]];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark gestures

- (void)btnFunctionClicked:(UIButton *)sender {
    NSInteger index = sender.tag % 10;
    
    NSLog(@"btnFunctionClicked: %li", index);
    WS(weakSelf)
    [GlobalTool popAlertWithTitle:[NSString stringWithFormat:@"确定%@？", index == 0 ? @"开始" : @"结束"] message:nil yesStr:@"确定" yesActionBlock:^{
        if (index == 0) {
            [weakSelf tryToStart];
        } else if (index == 1) {
            [weakSelf tryToTerminate];
        }
    }];
}

- (void)tryToStart {
    [SVProgressHUD show];
    
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_PLAN_GET_ACTION_START parameters:@{@"id":self.detailData.ID} shouldCache:NO success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD showInfoWithStatus:@"操作成功"];
        NSLog(@"MAINTENANCE_PLAN_GET_ACTION_START: %@", responseJson);
        if (code == 0) {
            [SVProgressHUD showInfoWithStatus:message];
            return ;
        }
                
        [SVProgressHUD showInfoWithStatus:@"操作成功"];
        [weakSelf back];
        if (weakSelf.backBlock) {
            weakSelf.backBlock();
        }
    }];
}

- (void)tryToTerminate {
    [SVProgressHUD show];
    
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_PLAN_GET_ACTION_END parameters:@{@"id":self.detailData.ID} shouldCache:NO success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"MAINTENANCE_PLAN_GET_ACTION_END: %@", responseJson);
        if (code == 0) {
            [SVProgressHUD showInfoWithStatus:message];
            return ;
        }
                
        [SVProgressHUD showInfoWithStatus:@"操作成功"];
        [weakSelf back];
        if (weakSelf.backBlock) {
            weakSelf.backBlock();
        }
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ProblemMaintenancePlanDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemMaintenancePlanDetailTitleCell.cellIdentifier forIndexPath:indexPath];
        
        [cell resetSubviewsWithTitle:[NSString stringWithFormat:@"%@|%@", self.detailData.EquipCode, self.detailData.EquipName]];
        
        return cell;
    } else {
        ProblemMaintenancePlanDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemMaintenancePlanDetailInfoCell.cellIdentifier forIndexPath:indexPath];
        
        [cell resetSubviewsWithData:self.detailData];
        
        return cell;
    }
}

@end
