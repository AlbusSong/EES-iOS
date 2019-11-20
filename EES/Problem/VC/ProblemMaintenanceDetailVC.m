//
//  ProblemMaintenanceDetailVC.m
//  EES
//
//  Created by Albus on 2019-11-20.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceDetailVC.h"
#import "ProblemMaintenanceDetailTitleCell.h"
#import "ProblemMaintenanceDetailReportInfoCell.h"
#import "ProblemMaintenanceDetailInfoCell.h"

@interface ProblemMaintenanceDetailVC ()

@end

@implementation ProblemMaintenanceDetailVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"维修工单明细";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];
}

#pragma mark init subviews

- (void)initSubviews {
    [self.tableView registerClass:[ProblemMaintenanceDetailTitleCell class] forCellReuseIdentifier:ProblemMaintenanceDetailTitleCell.cellIdentifier];
    [self.tableView registerClass:[ProblemMaintenanceDetailReportInfoCell class] forCellReuseIdentifier:ProblemMaintenanceDetailReportInfoCell.cellIdentifier];
    [self.tableView registerClass:[ProblemMaintenanceDetailInfoCell class] forCellReuseIdentifier:ProblemMaintenanceDetailInfoCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 50, 0));
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
        ProblemMaintenanceDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemMaintenanceDetailTitleCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    } else if (indexPath.row == 1) {
        ProblemMaintenanceDetailReportInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemMaintenanceDetailReportInfoCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    } else {
        ProblemMaintenanceDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemMaintenanceDetailInfoCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
}

@end
