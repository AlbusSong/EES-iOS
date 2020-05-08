//
//  ProblemMaintenanceEditInfoVC.m
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceEditInfoVC.h"
#import "MaintenanceDetailModel.h"

#import "MaintenanceEditInfoCell.h"
#import "MaintenanceEditInputSelectionCell.h"
#import "MaintenanceEditInputContentCell.h"

#import "ProblemAnswerSelectionVC.h"

#import "MaintenanceEditInfoLevelModel.h"
#import "MaintenanceEditInfoRoleModel.h"
#import "MaintenanceEditInfoFailCodeModel.h"

@interface ProblemMaintenanceEditInfoVC () <MaintenanceEditInputContentCellDelegate>

@property (nonatomic, strong) NSMutableArray *arrOfInfo;

@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic, copy) NSString *content;

@end

@implementation ProblemMaintenanceEditInfoVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.arrOfInfo = [NSMutableArray array];
        self.selectedIndex = -1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.editInfoType == MaintenanceEditInfoType_ChangeLevel) {
        self.title = @"维修等级修改";
    } else if (self.editInfoType == MaintenanceEditInfoType_ChangeRole) {
        self.title = @"维修角色修改";
    } else if (self.editInfoType == MaintenanceEditInfoType_WeiwaiApply) {
        self.title = @"维修委外申请";
    } else if (self.editInfoType == MaintenanceEditInfoType_Report) {
        self.title = @"故障维修报工";
    }
    
    [self.arrOfInfo addObject:[NSString stringWithFormat:@"设备名称：%@|%@", AVOIDNULL(self.detailData.EquipCode), AVOIDNULL(self.detailData.EquipName)]];
    [self.arrOfInfo addObject:[NSString stringWithFormat:@"故障时间：%@", AVOIDNULL(self.detailData.FaultStartTime)]];
    [self.arrOfInfo addObject:[NSString stringWithFormat:@"维修时间：%@", AVOIDNULL(self.detailData.WorkOrderStarTime)]];
//    NSInteger secondsDuration = [[NSDate date] timeIntervalSince1970] - [GlobalTool dateFromString:self.detailData.FaultStartTime format:@"yyyy-MM-dd'T'HH:mm:ss.SSS"].timeIntervalSince1970;
    [self.arrOfInfo addObject:[NSString stringWithFormat:@"持续时间：%@分钟", AVOIDNULL(self.detailData.RequestTimeLenSS)]];
    if (self.editInfoType == MaintenanceEditInfoType_ChangeLevel) {
        [self.arrOfInfo addObject:[NSString stringWithFormat:@"当前等级：%@", AVOIDNULL(self.detailData.LevelDesc)]];
    } else if (self.editInfoType == MaintenanceEditInfoType_ChangeRole) {
        [self.arrOfInfo addObject:[NSString stringWithFormat:@"当前角色：%@", AVOIDNULL(self.detailData.RoleName)]];
    }
    
    
    [self.tableView registerClass:[MaintenanceEditInfoCell class] forCellReuseIdentifier:MaintenanceEditInfoCell.cellIdentifier];
    [self.tableView registerClass:[MaintenanceEditInputSelectionCell class] forCellReuseIdentifier:MaintenanceEditInputSelectionCell.cellIdentifier];
    [self.tableView registerClass:[MaintenanceEditInputContentCell class] forCellReuseIdentifier:MaintenanceEditInputContentCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
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
    
    [self getDataFromServer];
    
    
//    NSDate *date = [self dateFromString:self.detailData.FaultStartTime format:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
//    NSInteger timeDelta = [[NSDate date] timeIntervalSince1970] - date.timeIntervalSince1970;
//    NSLog(@"dateFromString: %@, %i", date, timeDelta);
}



#pragma mark gestures

- (void)btnSubmitClicked {
    if (self.selectedIndex < 0 && self.editInfoType != MaintenanceEditInfoType_WeiwaiApply) {
        [SVProgressHUD showInfoWithStatus:@"请选择一项"];
        return;
    }
    
    if (self.editInfoType == MaintenanceEditInfoType_WeiwaiApply && self.content.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"申请项目不能为空"];
        return;
    }
    
    if (self.content.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写备注"];
        return;
    }
    
    WS(weakSelf)
    [GlobalTool popAlertWithTitle:@"确定操作?" message:nil yesStr:@"确定" yesActionBlock:^{
        [weakSelf realActionOfSubmission];
    }];
}

- (void)realActionOfSubmission {
    WS(weakSelf)
    if (self.editInfoType == MaintenanceEditInfoType_ChangeLevel) {
        MaintenanceEditInfoLevelModel *model = self.arrOfData[self.selectedIndex];
        [SVProgressHUD show];
        [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_ACTION_CHANGE_LEVEL parameters:@{@"workOrderNo":self.detailData.BMWorkOrder, @"bmlevel":model.Code, @"bmlevelremark":self.content ? self.content : @""} shouldCache:NO success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
            [SVProgressHUD showInfoWithStatus:@"操作成功"];
            NSLog(@"MAINTENANCE_ACTION_CHANGE_LEVEL: %@", responseJson);
            if (weakSelf.backBlock) {
                weakSelf.backBlock();
            }
            [weakSelf back];
        }];
    } else if (self.editInfoType == MaintenanceEditInfoType_ChangeRole) {
        MaintenanceEditInfoRoleModel *model = self.arrOfData[self.selectedIndex];
        [SVProgressHUD show];
        [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_ACTION_CHANGE_ROLE parameters:@{@"workOrderNo":self.detailData.BMWorkOrder, @"maintancerole":model.Code, @"maintanceroleremark":self.content ? self.content : @""} shouldCache:NO success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
            [SVProgressHUD showInfoWithStatus:@"操作成功"];
            NSLog(@"MAINTENANCE_ACTION_CHANGE_ROLE: %@", responseJson);
            if (weakSelf.backBlock) {
                weakSelf.backBlock();
            }
            [weakSelf back];
        }];
    } else if (self.editInfoType == MaintenanceEditInfoType_WeiwaiApply) {
        [SVProgressHUD show];
        [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_ACTION_WEIWAI_APPLY parameters:@{@"workOrderNo":self.detailData.BMWorkOrder, @"vendoritem":self.content ? self.content : @""} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
            [SVProgressHUD showInfoWithStatus:@"操作成功"];
            NSLog(@"MAINTENANCE_ACTION_WEIWAI_APPLY: %@", responseJson);
            if (weakSelf.backBlock) {
                weakSelf.backBlock();
            }
            [weakSelf back];
        }];
    } else if (self.editInfoType == MaintenanceEditInfoType_Report) {
        [SVProgressHUD show];
        MaintenanceEditInfoFailCodeModel *model = self.arrOfData[self.selectedIndex];
        [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_ACTION_REPORT parameters:@{@"workOrderNo":self.detailData.BMWorkOrder, @"failcode":model.BDCCode, @"prestremark":self.content ? self.content : @""} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
            [SVProgressHUD showInfoWithStatus:@"操作成功"];
            NSLog(@"MAINTENANCE_ACTION_REPORT: %@", responseJson);
            if (weakSelf.backBlock) {
                weakSelf.backBlock();
            }
            [weakSelf back];
        }];
    }
}

#pragma mark network

- (void)getDataFromServer {
    WS(weakSelf)
    if (self.editInfoType == MaintenanceEditInfoType_ChangeLevel) {
        [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_GET_LEVEL_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
            NSLog(@"MAINTENANCE_GET_LEVEL_LIST: %@", responseJson);
            weakSelf.arrOfData = [MaintenanceEditInfoLevelModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
        }];
    } else if (self.editInfoType == MaintenanceEditInfoType_ChangeRole) {
        [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_GET_ROLE_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
            NSLog(@"MAINTENANCE_GET_ROLE_LIST: %@", responseJson);
            weakSelf.arrOfData = [MaintenanceEditInfoRoleModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
        }];
    } else if (self.editInfoType == MaintenanceEditInfoType_WeiwaiApply) {
        
    } else if (self.editInfoType == MaintenanceEditInfoType_Report) {
        [[EESHttpDigger sharedInstance] postWithUri:MAINTENANCE_GET_FAILCODE_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
            NSLog(@"MAINTENANCE_GET_FAILCODE_LIST: %@", responseJson);
            weakSelf.arrOfData = [MaintenanceEditInfoFailCodeModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
        }];
    }
}

#pragma mark MaintenanceEditInputContentCellDelegate

- (void)contentHasChangedTo:(NSString *)newContent {
    NSLog(@"newContent: %@", newContent);
    self.content = newContent;
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 1) {
        NSMutableArray *arrOfSelectionTitle = [NSMutableArray array];
        
        if (self.editInfoType == MaintenanceEditInfoType_ChangeLevel) {
            for (MaintenanceEditInfoLevelModel *m in self.arrOfData) {
                [arrOfSelectionTitle addObject:m.Remark];
            }
        } else if (self.editInfoType == MaintenanceEditInfoType_ChangeRole) {
            for (MaintenanceEditInfoRoleModel *m in self.arrOfData) {
                [arrOfSelectionTitle addObject:m.Name];
            }
        } else if (self.editInfoType == MaintenanceEditInfoType_WeiwaiApply) {

        } else if (self.editInfoType == MaintenanceEditInfoType_Report) {
            for (MaintenanceEditInfoFailCodeModel *m in self.arrOfData) {
                [arrOfSelectionTitle addObject:m.Description];
            }
        }
        
        ProblemAnswerSelectionVC *vcOfAnswerSelection = [[ProblemAnswerSelectionVC alloc] init];
        vcOfAnswerSelection.arrOfData = arrOfSelectionTitle;
        WS(weakSelf)
        vcOfAnswerSelection.confirmationBlock = ^(NSInteger index, NSString * _Nonnull title) {
            MaintenanceEditInputSelectionCell *selectionCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectionCell setContent:title];
            
            weakSelf.selectedIndex = index;
        };
        [self presentViewController:vcOfAnswerSelection animated:NO completion:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        if (self.editInfoType == MaintenanceEditInfoType_WeiwaiApply) {
            return CGFLOAT_MIN;
        } else {
            return 60;
        }
    } else if (indexPath.row == 2) {
        return 140;
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
    if (indexPath.row == 0) {
        MaintenanceEditInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:MaintenanceEditInfoCell.cellIdentifier forIndexPath:indexPath];
        
        [cell resetSubviewsWithInfoArray:self.arrOfInfo];
        
        return cell;
    } else if (indexPath.row == 1) {
        MaintenanceEditInputSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:MaintenanceEditInputSelectionCell.cellIdentifier forIndexPath:indexPath];
        
//        [cell resetSubviewsWithData:self.detailData];
        if (self.editInfoType == MaintenanceEditInfoType_ChangeLevel) {
            [cell resetTitle:@"变更等级："];
        } else if (self.editInfoType == MaintenanceEditInfoType_ChangeRole) {
            [cell resetTitle:@"变更角色："];
        } else if (self.editInfoType == MaintenanceEditInfoType_WeiwaiApply) {
            [cell resetTitle:@"："];
        } else if (self.editInfoType == MaintenanceEditInfoType_Report) {
            [cell resetTitle:@"故障代码："];
        }
        
        return cell;
    } else {
        MaintenanceEditInputContentCell *cell = [tableView dequeueReusableCellWithIdentifier:MaintenanceEditInputContentCell.cellIdentifier forIndexPath:indexPath];
        
        cell.delegate = self;
        
        [cell resetTitle:@"修改备注："];
        [cell resetPlaceholder:@"修改备注"];
        if (self.editInfoType == MaintenanceEditInfoType_WeiwaiApply) {
            [cell resetTitle:@"申请项目："];
            [cell resetPlaceholder:@"申请项目"];
        } else if (self.editInfoType == MaintenanceEditInfoType_Report) {
            [cell resetTitle:@"维修对策："];
            [cell resetPlaceholder:@"维修对策"];
        }
        
        return cell;
    }
}


@end
