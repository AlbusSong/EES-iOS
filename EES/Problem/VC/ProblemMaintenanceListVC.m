//
//  ProblemMaintenanceList.m
//  EES
//
//  Created by Albus on 20/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceListVC.h"
#import "ProblemSearchBar.h"
#import "ProblemMaintenanceItemCell.h"

#import "ProblemMaintenanceDetailVC.h"

@interface ProblemMaintenanceListVC ()<ProblemSearchBarDelegate>

@property (nonatomic, copy) NSString *searchContent;

@end

@implementation ProblemMaintenanceListVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"维修工单";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ProblemSearchBar *searchBar = [[ProblemSearchBar alloc] init];
    searchBar.backgroundColor = UIColor.whiteColor;
    searchBar.delegate = self;
    [searchBar setSearchHint:@"设备名称"];
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    [self.tableView registerClass:[ProblemMaintenanceItemCell class] forCellReuseIdentifier:ProblemMaintenanceItemCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(45, 0, 0, 0));
    }];
}

#pragma mark ProblemSearchBarDelegate

- (void)searchContentChangedTo:(NSString *)newSearchContent {
    self.searchContent = newSearchContent;
}

- (void)tryToSearch {
    if (self.searchContent.length == 0) {
        return;
    }
    
    [self.view endEditing:YES];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ProblemMaintenanceDetailVC *vc = [[ProblemMaintenanceDetailVC alloc] init];
    [self pushVC:vc];
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
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProblemMaintenanceItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemMaintenanceItemCell.cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
