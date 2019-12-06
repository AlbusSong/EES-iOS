//
//  ProblemGroupCheckListVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemGroupCheckListVC.h"
#import "ProblemGroupCheckItemCell.h"
#import "ProblemSearchBar.h"

#import "ProblemGroupCheckItemVC.h"

#import "GroupCheckItemModel.h"

@interface ProblemGroupCheckListVC () <ProblemSearchBarDelegate>

@property (nonatomic, copy) NSString *searchContent;

@end

@implementation ProblemGroupCheckListVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"班组点检";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentPage = 10;
    
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
    
    [self.tableView registerClass:[ProblemGroupCheckItemCell class] forCellReuseIdentifier:ProblemGroupCheckItemCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(45, 0, 0, 0));
    }];
    
    WS(weakSelf)
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage += 10;
        [weakSelf getDataFromServerShouldShowHUD:NO];
    }];
    self.tableView.mj_footer.hidden = YES;
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServerShouldShowHUD:(BOOL)shouldShow {
    if (shouldShow) {
        [SVProgressHUD show];
    }
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:GROUP_CHECK_GET_LIST parameters:@{@"equipName":self.searchContent ? self.searchContent : @"", @"size":@(self.currentPage)} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD dismiss];
        NSLog(@"GROUP_CHECK_GET_LIST: %@", responseJson);
        NSArray *arr = [GroupCheckItemModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
        [weakSelf.arrOfData addObjectsFromArray:arr];
        [weakSelf.tableView reloadData];
        
        if (arr.count > 0) {
            [weakSelf.tableView.mj_footer endRefreshing];
        } else {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

- (void)getDataFromServer {
    [self getDataFromServerShouldShowHUD:YES];
}

#pragma mark ProblemSearchBarDelegate

- (void)searchContentChangedTo:(NSString *)newSearchContent {
    self.searchContent = newSearchContent;
}

- (void)tryToSearch {
    [self getDataFromServer];
    
    [self.view endEditing:YES];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ProblemGroupCheckItemVC *vc = [[ProblemGroupCheckItemVC alloc] init];
    vc.data = [self.arrOfData objectAtIndex:indexPath.row];
    [self pushVC:vc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.arrOfData.count == 0);
    return self.arrOfData.count;
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
    ProblemGroupCheckItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemGroupCheckItemCell.cellIdentifier forIndexPath:indexPath];
    
    [cell resetSubviewsWithData:self.arrOfData[indexPath.row]];
    
    return cell;
}

@end
