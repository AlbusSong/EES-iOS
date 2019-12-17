//
//  ProblemMaintenanceConfirmationListVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceConfirmationListVC.h"
#import "ProblemMaintenanceConfirmationItemCell.h"
#import "ProblemSearchBar.h"

#import "MaintenanceConfirmationItemModel.h"

@interface ProblemMaintenanceConfirmationListVC () <ProblemSearchBarDelegate>

@property (nonatomic, copy) NSString *searchContent;

@property (nonatomic) NSInteger selectedIndex;

@end

@implementation ProblemMaintenanceConfirmationListVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"维修确认";
        self.selectedIndex = -1;
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
    
    [self.tableView registerClass:[ProblemMaintenanceConfirmationItemCell class] forCellReuseIdentifier:ProblemMaintenanceConfirmationItemCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(45, 0, 50, 0));
    }];
    
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnConfirm setTitle:@"通过" forState:UIControlStateNormal];
    [btnConfirm setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
    [btnConfirm addTarget:self action:@selector(btnConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.right.mas_equalTo(self.view.mas_centerX).offset(-1);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
    
    UIButton *btnReject = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReject.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btnReject setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnReject setTitle:@"驳回" forState:UIControlStateNormal];
    [btnReject setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
    [btnReject addTarget:self action:@selector(btnRejectClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReject];
    [btnReject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.left.mas_equalTo(self.view.mas_centerX).offset(1);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
    
    [self getDataFromServer];
}

#pragma mark gestures

- (void)btnConfirmClicked {
    if (self.selectedIndex < 0 || self.selectedIndex >= self.arrOfData.count) {
        [SVProgressHUD showInfoWithStatus:@"请先选择一项"];
        return;
    }
    
    [GlobalTool popAlertWithTitle:@"确定通过？" message:nil yesStr:@"确定" yesActionBlock:^{
        [self confirmAction];
    }];
}

- (void)confirmAction {
    [SVProgressHUD show];
    
    MaintenanceConfirmationItemModel *selectedModel = [self.arrOfData objectAtIndex:self.selectedIndex];
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_CONFIRMATION_ACTION_APPROVE parameters:@{@"no":selectedModel.BMWorkOrder} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"MAINTENANCE_CONFIRMATION_ACTION_APPROVE: %@", responseJson);
        if (code == 0) {
            [SVProgressHUD showInfoWithStatus:message];
            return;
        }
        
        [SVProgressHUD showInfoWithStatus:@"操作成功"];
        [weakSelf.arrOfData removeObjectAtIndex:weakSelf.selectedIndex];
        weakSelf.selectedIndex = -1;
        [weakSelf.tableView reloadData];
    }];
}

- (void)btnRejectClicked {
    
    if (self.selectedIndex < 0 || self.selectedIndex >= self.arrOfData.count) {
        [SVProgressHUD showInfoWithStatus:@"请先选择一项"];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定拒绝？" message:@"请输入驳回原因" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"原因";
    }];
    
    WS(weakSelf)
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *tfdOfReason = alertController.textFields.firstObject;
        [weakSelf rejectActionWithReason:tfdOfReason.text];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)rejectActionWithReason:(NSString *)reason {
    if (reason.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入拒绝原因"];
        return;
    }
    
    [SVProgressHUD show];
    
    MaintenanceConfirmationItemModel *selectedModel = [self.arrOfData objectAtIndex:self.selectedIndex];
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_CONFIRMATION_ACTION_REJECT parameters:@{@"no":selectedModel.BMWorkOrder, @"reason":reason} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"MAINTENANCE_CONFIRMATION_ACTION_APPROVE: %@", responseJson);
        if (code == 0) {
            [SVProgressHUD showInfoWithStatus:message];
            return;
        }
        
        [SVProgressHUD showInfoWithStatus:@"操作成功"];
        [weakSelf.arrOfData removeObjectAtIndex:weakSelf.selectedIndex];
        weakSelf.selectedIndex = -1;
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_CONFIRMATION_GET_LIST parameters:@{@"equipCode": self.searchContent ? self.searchContent : @""} shouldCache:YES success:^(int code, NSString * _Nonnull msg, id  _Nonnull responseJson) {
        [SVProgressHUD dismiss];
        NSLog(@"MAINTENANCE_CONFIRMATION_GET_LIST: %@", responseJson);
        
        weakSelf.arrOfData = [MaintenanceConfirmationItemModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
        [weakSelf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"MAINTENANCE_CONFIRMATION_GET_LIST error: %@", error);
    }];
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
    
    if (self.selectedIndex == indexPath.row) {
        return;
    }
    
    self.selectedIndex = indexPath.row;
    [tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    ProblemMaintenanceConfirmationItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemMaintenanceConfirmationItemCell.cellIdentifier forIndexPath:indexPath];
    
    [cell resetSubviewsWithData:self.arrOfData[indexPath.row]];
    [cell showSelected:(indexPath.row == self.selectedIndex)];
    
    return cell;
}

@end
