//
//  ProblemReportListVC.m
//  EES
//
//  Created by Albus on 20/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemReportListVC.h"
#import "ProblemReportItemCell.h"

#import "ProblemSearchBar.h"

@interface ProblemReportListVC () <ProblemSearchBarDelegate>

@property (nonatomic, copy) NSString *searchContent;

@end

@implementation ProblemReportListVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"报修清单";
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
    
    [self.tableView registerClass:[ProblemReportItemCell class] forCellReuseIdentifier:ProblemReportItemCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(45, 0, 50, 0));
    }];
    
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnConfirm setTitle:@"接受" forState:UIControlStateNormal];
    [btnConfirm setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
    [self.view addSubview:btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.right.mas_equalTo(self.view.mas_centerX).offset(-1);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
    
    UIButton *btnReject = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReject.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btnReject setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnReject setTitle:@"拒绝" forState:UIControlStateNormal];
    [btnReject setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
    [self.view addSubview:btnReject];
    [btnReject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.left.mas_equalTo(self.view.mas_centerX).offset(1);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServer {
    [[HttpDigger sharedInstance] postWithUri:PROBLEM_REPORT_LIST parameters:@{@"equipCode":@""} success:^(int code, NSString * _Nonnull msg, id  _Nonnull responseJson) {
        NSLog(@"PROBLEM_REPORT_LIST: %@", responseJson);
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
//    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProblemReportItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemReportItemCell.cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
