//
//  ProblemWholeCheckSubmitVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckSubmitVC.h"
#import "ProblemWholeCheckSubmitTitleCell.h"
#import "ProblemWholeCheckSubmitInfoCell.h"
#import "ProblemWholeCheckSubmitSegmentControlCell.h"
#import "ProblemNewReportContentCell.h"
#import "ProblemWholeCheckSubmitAttachmentCell.h"

#import "WholeCheckDetailItemModel.h"

@interface ProblemWholeCheckSubmitVC ()

@end

@implementation ProblemWholeCheckSubmitVC

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
    
    [self.tableView registerClass:[ProblemWholeCheckSubmitTitleCell class] forCellReuseIdentifier:ProblemWholeCheckSubmitTitleCell.cellIdentifier];
    [self.tableView registerClass:[ProblemWholeCheckSubmitInfoCell class] forCellReuseIdentifier:ProblemWholeCheckSubmitInfoCell.cellIdentifier];
    [self.tableView registerClass:[ProblemWholeCheckSubmitSegmentControlCell class] forCellReuseIdentifier:ProblemWholeCheckSubmitSegmentControlCell.cellIdentifier];
    [self.tableView registerClass:[ProblemNewReportContentCell class] forCellReuseIdentifier:ProblemNewReportContentCell.cellIdentifier];
    [self.tableView registerClass:[ProblemWholeCheckSubmitAttachmentCell class] forCellReuseIdentifier:ProblemWholeCheckSubmitAttachmentCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
    if (self.state != 1) {
        UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnConfirm setTitle:@"提交" forState:UIControlStateNormal];
        [btnConfirm setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
        [self.view addSubview:btnConfirm];
        [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(self.view);
            make.right.mas_equalTo(self.view).offset(0);
            make.height.mas_equalTo(50);
        }];
    }
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:WHOLE_CHECK_GET_DETAIL_ITEM_DETIAL parameters:@{@"cmaProjectNo":self.data.CMAProjectNo} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"WHOLE_CHECK_GET_DETAIL_ITEM_DETIAL: %@", responseJson);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"WHOLE_CHECK_GET_DETAIL_ITEM_DETIAL error: %@", error);
    }];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.state == 1) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        if (self.state == 0) {
             return 4;
        } else {
             return 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.state == 2 && indexPath.section == 1) {
        return 140;
    }
    if (self.state == 0 && indexPath.section == 1 && (indexPath.row == 1 || indexPath.row == 2)) {
        return 140;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ProblemWholeCheckSubmitTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemWholeCheckSubmitTitleCell.cellIdentifier forIndexPath:indexPath];
            
            return cell;
        } else {
            ProblemWholeCheckSubmitInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemWholeCheckSubmitInfoCell.cellIdentifier forIndexPath:indexPath];
            
            return cell;
        }
    } else {
        if (self.state == 0) {
            if (indexPath.row == 0) {
                ProblemWholeCheckSubmitSegmentControlCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemWholeCheckSubmitSegmentControlCell.cellIdentifier forIndexPath:indexPath];
                
                return cell;
            } else if (indexPath.row == 1) {
                ProblemNewReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportContentCell.cellIdentifier forIndexPath:indexPath];
                
                [cell setPlaceholder:@"现象"];
                
                return cell;
            } else if (indexPath.row == 2) {
                ProblemNewReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportContentCell.cellIdentifier forIndexPath:indexPath];
                
                [cell setPlaceholder:@"对策"];
                
                return cell;
            } else {
                ProblemWholeCheckSubmitAttachmentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemWholeCheckSubmitAttachmentCell.cellIdentifier forIndexPath:indexPath];
                
                return cell;
            }
        } else if (self.state == 2) {
            ProblemNewReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportContentCell.cellIdentifier forIndexPath:indexPath];
            
            [cell setPlaceholder:@"异常处理备注"];
            
            return cell;
        }
    }
    return [ASTableViewCell new];
}

@end
