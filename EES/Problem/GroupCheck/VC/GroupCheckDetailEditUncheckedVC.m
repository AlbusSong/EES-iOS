//
//  GroupCheckDetailEditUncheckedVC.m
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "GroupCheckDetailEditUncheckedVC.h"
#import "GroupCheckDetailEditUncheckedTitleCell.h"
#import "GroupCheckDetailEditUncheckedInfoCell.h"
#import "ProblemNewReportSelectionCell.h"
#import "ProblemNewReportContentCell.h"

#import "GroupCheckDetailItemModel.h"
#import "MaintenanceEditInfoRoleModel.h"

#import "ProblemAnswerSelectionVC.h"

@interface GroupCheckDetailEditUncheckedVC () <ProblemNewReportContentCellDelegate>

@property (nonatomic, copy) NSString *problemContent;

@property (nonatomic) NSInteger selectedIndex;

@end

@implementation GroupCheckDetailEditUncheckedVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"班组点检";
        
        self.selectedIndex = -1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[GroupCheckDetailEditUncheckedTitleCell class] forCellReuseIdentifier:GroupCheckDetailEditUncheckedTitleCell.cellIdentifier];
    [self.tableView registerClass:[GroupCheckDetailEditUncheckedInfoCell class] forCellReuseIdentifier:GroupCheckDetailEditUncheckedInfoCell.cellIdentifier];
    [self.tableView registerClass:[ProblemNewReportSelectionCell class] forCellReuseIdentifier:ProblemNewReportSelectionCell.cellIdentifier];
    [self.tableView registerClass:[ProblemNewReportContentCell class] forCellReuseIdentifier:ProblemNewReportContentCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, self.state == 2 ? 50 : 0, 0));
    }];
    
    if (self.state == 2) {
        UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSubmit.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
        [btnSubmit setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
        [btnSubmit addTarget:self action:@selector(btnSubmitClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSubmit];
        [btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view);
            make.top.mas_equalTo(self.tableView.mas_bottom);
        }];
    }
    
    [self getDataFromServer];
}

#pragma mark gestures

- (void)getDataFromServer {
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_GET_ROLE_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"MAINTENANCE_GET_ROLE_LIST: %@", responseJson);
        weakSelf.arrOfData = [MaintenanceEditInfoRoleModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
    }];
}

#pragma mark gestures

- (void)btnSubmitClicked {
    if (self.selectedIndex < 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择维修角色"];
        return;
    }
    
    if (self.problemContent.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入备注"];
        return;
    }
    
    WS(weakSelf)
    [GlobalTool popAlertWithTitle:@"确认提交？" message:nil yesStr:@"确认" yesActionBlock:^{
        [weakSelf submitAction];
    }];
}

- (void)submitAction {
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict setValue:self.data.CMSProjectNo forKey:@"cmsProjectNo"];
    [mDict setValue:self.data.WorkOrderNoApp forKey:@"cmsWorkOrderNo"];
    MaintenanceEditInfoRoleModel *role = [self.arrOfData objectAtIndex:self.selectedIndex];
    [mDict setValue:role.Code forKey:@"itemRole"];
    [mDict setValue:self.problemContent forKey:@"comment"];
    
    
    NSLog(@"CMSWorkOrder/Deal mDict: %@", mDict);
    [SVProgressHUD show];
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:GROUP_CHECK_ACTION_DETAIL_ITEM_UNCHECKED_SUBMIT parameters:@{} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"GROUP_CHECK_ACTION_DETAIL_ITEM_UNCHECKED_SUBMIT: %@", responseJson);
        if (code == 0) {
            [SVProgressHUD showInfoWithStatus:message];
            return ;
        }
        
        [SVProgressHUD showInfoWithStatus:@"操作成功"];
        [weakSelf back];
        if (weakSelf.backBlock) {
            weakSelf.backBlock();
        }
    }];
}

#pragma mark ProblemNewReportContentCellDelegate

- (void)contentHasChangedTo:(NSString *)newContent {
    self.problemContent = newContent;
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        ProblemNewReportSelectionCell *selectionCell = (ProblemNewReportSelectionCell *)[tableView cellForRowAtIndexPath:indexPath];
        [selectionCell showHilighted:YES];
        
        NSMutableArray *arrOfSelectionTitle = [NSMutableArray array];
        for (MaintenanceEditInfoRoleModel *m in self.arrOfData) {
            [arrOfSelectionTitle addObject:m.Name];
        }
        ProblemAnswerSelectionVC *vcOfAnswerSelection = [[ProblemAnswerSelectionVC alloc] init];
        vcOfAnswerSelection.arrOfData = arrOfSelectionTitle;
        WS(weakSelf)
        vcOfAnswerSelection.confirmationBlock = ^(NSInteger index, NSString * _Nonnull title) {
            [selectionCell setContent:title];
            [selectionCell showHilighted:NO];
            weakSelf.selectedIndex = index;
        };
        vcOfAnswerSelection.cancelBlock = ^{
            [selectionCell showHilighted:NO];
        };
        [self presentViewController:vcOfAnswerSelection animated:NO completion:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.state == 2 ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 60;
        } else if (indexPath.row == 1) {
            return 140;
        }
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            GroupCheckDetailEditUncheckedTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:GroupCheckDetailEditUncheckedTitleCell.cellIdentifier forIndexPath:indexPath];
            
            [cell resetSubviewsWithTitle:[NSString stringWithFormat:@"项目：%@", self.data.Project]];
            
            return cell;
        } else {
            GroupCheckDetailEditUncheckedInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:GroupCheckDetailEditUncheckedInfoCell.cellIdentifier forIndexPath:indexPath];
            
            [cell resetSubviewsWithData:self.data];
            
            return cell;
        }
    } else {
        if (indexPath.row == 0) {
            ProblemNewReportSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportSelectionCell.cellIdentifier forIndexPath:indexPath];
            
            [cell resetTitle:@"维修角色"];
            
            return cell;
        } else {
            ProblemNewReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportContentCell.cellIdentifier forIndexPath:indexPath];
            
            cell.delegate = self;
            
            [cell resetTitle:@"异常处理备注"];
            
            return cell;
        }
    }
    return [ASTableViewCell new];
}

@end
