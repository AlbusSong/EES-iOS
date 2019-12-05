//
//  ProblemWholeCheckListVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckListVC.h"
#import "ProblemWholeCheckItemCell.h"
#import "ProblemSearchBar.h"

#import "ProblemWholeCheckItemVC.h"

#import "WholeCheckItemModel.h"

@interface ProblemWholeCheckListVC ()<ProblemSearchBarDelegate>

@property (nonatomic, copy) NSString *searchContent;

@end

@implementation ProblemWholeCheckListVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"保全点检";
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
    
    [self.tableView registerClass:[ProblemWholeCheckItemCell class] forCellReuseIdentifier:ProblemWholeCheckItemCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(45, 0, 0, 0));
    }];
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    WeakSelf(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:WHOLE_CHECK_GET_LIST parameters:@{@"equipName":self.searchContent ? self.searchContent : @""} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD dismiss];
        NSLog(@"WHOLE_CHECK_GET_LIST: %@", responseJson);
        weakSelf.arrOfData = [WholeCheckItemModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
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
    
    ProblemWholeCheckItemVC *vc = [[ProblemWholeCheckItemVC alloc] init];
    vc.data = self.arrOfData[indexPath.row];
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProblemWholeCheckItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemWholeCheckItemCell.cellIdentifier forIndexPath:indexPath];
    
    [cell resetSubviewsWithData:self.arrOfData[indexPath.row]];
    
    return cell;
}

@end
