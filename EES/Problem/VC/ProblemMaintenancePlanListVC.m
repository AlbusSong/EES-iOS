//
//  ProblemMaintenancePlanListVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenancePlanListVC.h"
#import "ProblemMaintenancePlanItemCell.h"

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
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    ProblemPeriodicalMaintenanceDetailVC *vc = [[ProblemPeriodicalMaintenanceDetailVC alloc] init];
//    [self pushVC:vc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
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
    
    return cell;
}

@end
