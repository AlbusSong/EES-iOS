//
//  ProblemPeriodicalMaintenanceListVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemPeriodicalMaintenanceListVC.h"
#import "ProblemSearchBar.h"
#import "ProblemPeriodicalMaintenanceItemCell.h"

#import "ProblemPeriodicalMaintenanceDetailVC.h"

#import "PeriodicalMaintenanceItemModel.h"

@interface ProblemPeriodicalMaintenanceListVC ()<ProblemSearchBarDelegate>

@property (nonatomic, copy) NSString *searchContent;

@property (nonatomic) NSInteger currentPage;

@end

@implementation ProblemPeriodicalMaintenanceListVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"定期保养";
        
        self.currentPage = 1;
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
    
    [self.tableView registerClass:[ProblemPeriodicalMaintenanceItemCell class] forCellReuseIdentifier:ProblemPeriodicalMaintenanceItemCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(45, 0, 0, 0));
    }];
    
    WS(weakSelf)
//    self.clv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        weakSelf.currentPage = 1;
//        [weakSelf getDataFromServer];
//    }];
//    
//    self.clv.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        weakSelf.currentPage++;
//        [weakSelf getDataFromServer];
//    }];
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:PERIODICAL_MAINTENANCE_GET_LIST parameters:@{@"size":@(10), @"equipCode": self.searchContent ? self.searchContent : @""} shouldCache:NO success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD dismiss];
        NSLog(@"PERIODICAL_MAINTENANCE_GET_LIST: %@", responseJson);
        NSArray *arr = [PeriodicalMaintenanceItemModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
        [weakSelf.arrOfData addObjectsFromArray:arr];
        [weakSelf.tableView reloadData];
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
    
    ProblemPeriodicalMaintenanceDetailVC *vc = [[ProblemPeriodicalMaintenanceDetailVC alloc] init];
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
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProblemPeriodicalMaintenanceItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemPeriodicalMaintenanceItemCell.cellIdentifier forIndexPath:indexPath];
    
    [cell resetSubviewsWithData:self.arrOfData[indexPath.row]];
    
    return cell;
}

@end
