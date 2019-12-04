//
//  ProblemPeriodicalMaintenanceDetailVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemPeriodicalMaintenanceDetailVC.h"
#import "ProblemPeriodicalMaintenanceDetailTitleCell.h"
#import "ProblemPeriodicalMaintenanceDetailInfoCell.h"
#import "ProblemPeriodicalMaintenanceDetailAttachmentCell.h"

#import "PeriodicalMaintenanceItemModel.h"
#import "PeriodicalMaintenanceDetailModel.h"

@interface ProblemPeriodicalMaintenanceDetailVC ()

@property (nonatomic, strong) PeriodicalMaintenanceDetailModel *detailData;

@end

@implementation ProblemPeriodicalMaintenanceDetailVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"定期保养详情";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[ProblemPeriodicalMaintenanceDetailTitleCell class] forCellReuseIdentifier:ProblemPeriodicalMaintenanceDetailTitleCell.cellIdentifier];
    [self.tableView registerClass:[ProblemPeriodicalMaintenanceDetailInfoCell class] forCellReuseIdentifier:ProblemPeriodicalMaintenanceDetailInfoCell.cellIdentifier];
    [self.tableView registerClass:[ProblemPeriodicalMaintenanceDetailAttachmentCell class] forCellReuseIdentifier:ProblemPeriodicalMaintenanceDetailAttachmentCell.cellIdentifier];
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
    [[EESHttpDigger sharedInstance] postWithUri:PERIODICAL_MAINTENANCE_GET_DETAIL parameters:@{@"workOrderNo":self.data.PMWorkOrderNo} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD dismiss];
        NSLog(@"PERIODICAL_MAINTENANCE_GET_DETAIL: %@", responseJson);
        
        weakSelf.detailData = [PeriodicalMaintenanceDetailModel mj_objectWithKeyValues:responseJson];
        [weakSelf.tableView reloadData];
    }];
    
    [[EESHttpDigger sharedInstance] postWithUri:PERIODICAL_MAINTENANCE_GET_ATTACHMENT parameters:@{@"planNo":self.data.PMPlanNO} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"PERIODICAL_MAINTENANCE_GET_ATTACHMENT: %@", responseJson);
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
    [[EESHttpDigger sharedInstance] postWithUri:PERIODICAL_MAINTENANCE_ACTION_START parameters:@{@"workOrderNo":self.detailData.PMWorkOrderNo} shouldCache:NO success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD showInfoWithStatus:@"操作成功"];
        NSLog(@"PERIODICAL_MAINTENANCE_ACTION_START: %@", responseJson);
        [weakSelf back];
        if (weakSelf.backBlock) {
            weakSelf.backBlock();
        }
    }];
}

- (void)tryToTerminate {
    [SVProgressHUD show];
    
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:PERIODICAL_MAINTENANCE_ACTION_END parameters:@{@"workOrderNo":self.detailData.PMWorkOrderNo} shouldCache:NO success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD showInfoWithStatus:@"操作成功"];
        NSLog(@"PERIODICAL_MAINTENANCE_ACTION_END: %@", responseJson);
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
    return 3;
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
        ProblemPeriodicalMaintenanceDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemPeriodicalMaintenanceDetailTitleCell.cellIdentifier forIndexPath:indexPath];
        
        [cell resetSubviewsWithTitle:[NSString stringWithFormat:@"%@|%@", self.detailData.EquipCode, self.detailData.EquipName]];
        
        return cell;
    } else if (indexPath.row == 1) {
        ProblemPeriodicalMaintenanceDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemPeriodicalMaintenanceDetailInfoCell.cellIdentifier forIndexPath:indexPath];
        
        [cell resetSubviewsWithData:self.detailData];
        
        return cell;
    } else {
        ProblemPeriodicalMaintenanceDetailAttachmentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemPeriodicalMaintenanceDetailAttachmentCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
}

@end
