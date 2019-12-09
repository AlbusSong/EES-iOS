//
//  ProblemGroupCheckDetailVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemGroupCheckDetailVC.h"
#import "ProblemGroupCheckDetailItemCell.h"
#import "ProblemGroupCheckDetailUncheckedItemCell.h"

#import "GroupCheckItemModel.h"
#import "GroupCheckDetailItemModel.h"

#import "GroupCheckDetailEditUncheckedVC.h"

@interface ProblemGroupCheckDetailVC () <ProblemGroupCheckDetailItemCellDelegate>

@end

@implementation ProblemGroupCheckDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[ProblemGroupCheckDetailItemCell class] forCellReuseIdentifier:ProblemGroupCheckDetailItemCell.cellIdentifier];
    [self.tableView registerClass:[ProblemGroupCheckDetailUncheckedItemCell class] forCellReuseIdentifier:ProblemGroupCheckDetailUncheckedItemCell.cellIdentifier];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, self.state == 0 ? 50 : 0, 0));
    }];
    
    if (self.state == 0) {
        UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSubmit.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnSubmit setTitle:@"确认" forState:UIControlStateNormal];
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

- (void)btnSubmitClicked {
    if (self.arrOfData.count == 0) {
        [SVProgressHUD showInfoWithStatus:@"无数据可提交"];
        return;
    }
    
    WS(weakSelf)
    [GlobalTool popAlertWithTitle:@"确定提交？" message:nil yesStr:@"确定" yesActionBlock:^{
        [weakSelf realSubmitAction];
    }];
}

- (void)realSubmitAction {
    [SVProgressHUD show];
    
    NSMutableArray *arrayResult = [NSMutableArray array];
    for (GroupCheckDetailItemModel *model in self.arrOfData) {
        if (ISAVAILABLESTRING(model.Actual) == NO) {
            continue;
        }
        NSString *cmsProjectNo = model.CMSProjectNo;
        NSString *actual = model.Actual;
        NSDictionary *obj = @{@"CMSProjectNo":cmsProjectNo, @"Actual":actual};
        [arrayResult addObject:obj];
    }
    
    if (arrayResult.count == 0) {
        [SVProgressHUD showInfoWithStatus:@"请至少修改一项数据"];
        return;
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict setValue:arrayResult forKey:@"arrayResult"];
    [mDict setValue:((arrayResult.count == self.arrOfData.count) ? @"true" : @"false") forKey:@"isPrest"];
    [mDict setValue:self.data.CMSPlanNo forKey:@"cmsPlanNo"];
    [mDict setValue:self.data.CMSWorkOrderNo forKey:@"cmsWorkOrderNo"];
    NSLog(@"GROUP_CHECK_ACTION_SUBMIT mDict: %@", mDict);
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:GROUP_CHECK_ACTION_SUBMIT parameters:@{@"arrayResult":arrayResult, @"isPrest":@"true"} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        if (code == 1) {
            [SVProgressHUD showInfoWithStatus:@"操作成功"];
            [weakSelf back];
        } else if (code == 0) {
            [SVProgressHUD showInfoWithStatus:message];
        }
        NSLog(@"GROUP_CHECK_ACTION_SUBMIT: %@", responseJson);
    }];
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    WS(weakSelf)
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict setValue:self.data.CMSPlanNo forKey:@"cmsPlanNo"];
    [mDict setValue:self.data.CMSWorkOrderNo forKey:@"cmsWorkOrderNo"];
    if (self.state == 0) {
        [mDict setValue:@"P" forKey:@"State"];
    } else if (self.state == 1) {
        [mDict setValue:@"W" forKey:@"State"];
    } else if (self.state == 2) {
        [mDict setValue:@"D" forKey:@"State"];
    }
    
    [[EESHttpDigger sharedInstance] postWithUri:GROUP_CHECK_GET_DETAIL_ITEM_LIST parameters:mDict shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD dismiss];
        NSLog(@"GROUP_CHECK_GET_DETAIL_ITEM_LIST: %@", responseJson);
        weakSelf.arrOfData = [GroupCheckDetailItemModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark ProblemGroupCheckDetailItemCellDelegate

- (void)numberHasChangedTo:(NSString *)numberString atIndexPath:(NSIndexPath *)indexPath {
    GroupCheckDetailItemModel *model = [self.arrOfData objectAtIndex:indexPath.row];
    model.Actual = numberString;
}

- (void)decisionHasChangedTo:(BOOL)isOkay atIndexPath:(NSIndexPath *)indexPath {
    GroupCheckDetailItemModel *model = [self.arrOfData objectAtIndex:indexPath.row];
    model.Actual = isOkay ? @"1" : @"0";
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.state == 0) {
        return;
    }
    
    GroupCheckDetailEditUncheckedVC *vc = [[GroupCheckDetailEditUncheckedVC alloc] init];
    vc.state = self.state;
    vc.data = [self.arrOfData objectAtIndex:indexPath.row];
    WS(weakSelf)
    vc.backBlock = ^{
        [weakSelf getDataFromServer];
    };
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
    if (self.state == 0) {
        ProblemGroupCheckDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemGroupCheckDetailItemCell.cellIdentifier forIndexPath:indexPath];
        
        cell.delegate = self;
        cell.indexPath = indexPath;
        
        [cell resetSubviewsWithData:self.arrOfData[indexPath.row]];
        
        return cell;
    } else {
        ProblemGroupCheckDetailUncheckedItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemGroupCheckDetailUncheckedItemCell.cellIdentifier forIndexPath:indexPath];
        
        [cell resetSubviewsWithData:[self.arrOfData objectAtIndex:indexPath.row]];
        [cell shouldShowProgressInfo:(self.state == 2)];
        
        return cell;
    }
}

@end
