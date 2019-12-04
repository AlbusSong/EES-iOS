//
//  ProblemMaintenancePlanListVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenancePlanListVC.h"
#import "ProblemMaintenancePlanItemCell.h"

#import "ProblemMaintenancePlanDetailVC.h"

#import "MaintenancePlanItemModel.h"

@interface ProblemMaintenancePlanListVC ()

@end

@implementation ProblemMaintenancePlanListVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"计划维修";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[ProblemMaintenancePlanItemCell class] forCellReuseIdentifier:ProblemMaintenancePlanItemCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServerShouldShowHUD:(BOOL)shouldShow {
    if (shouldShow) {
        [SVProgressHUD show];
    }
    
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_PLAN_GET_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        if (shouldShow) {
            [SVProgressHUD dismiss];
        }
        NSLog(@"MAINTENANCE_PLAN_GET_LIST: %@", responseJson);
        weakSelf.arrOfData = [MaintenancePlanItemModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
        [weakSelf.tableView reloadData];
    }];
}

- (void)getDataFromServer {
    [self getDataFromServerShouldShowHUD:YES];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ProblemMaintenancePlanDetailVC *vc = [[ProblemMaintenancePlanDetailVC alloc] init];
    [self pushVC:vc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrOfData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
//    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProblemMaintenancePlanItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemMaintenancePlanItemCell.cellIdentifier forIndexPath:indexPath];
    
    [cell resetSubviewsWithData:self.arrOfData[indexPath.row]];
    
    return cell;
}

@end
