//
//  SeasoningManagementVC.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "SeasoningManagementVC.h"
#import "SeasoningManagementFirstCell.h"
#import "SeasoningManagementSecondCell.h"
#import "MaintenanceEditInputSelectionCell.h"

#import "SeasoningManagementScanBarcodeVC.h"
#import "ProblemAnswerSelectionVC.h"

#import "SeasoningManagementDetailModel.h"
#import "SeasoningManagementDeviceModel.h"
#import "SeasoningManagementProjectModel.h"
#import "SeasoningManagementJixingModel.h"

@interface SeasoningManagementVC ()

@property (nonatomic, strong) UIButton *btnConfirm;


@property (nonatomic, copy) NSString *barcodeConntent;

@property (nonatomic, strong) SeasoningManagementDetailModel *detailData;


@property (nonatomic, copy) NSArray *arrOfProject;
@property (nonatomic, strong) SeasoningManagementProjectModel *selectedProject;

@property (nonatomic, copy) NSArray *arrOfJixing;
@property (nonatomic, strong) SeasoningManagementJixingModel *selectedJixing;

@property (nonatomic, copy) NSArray *arrOfDevice;
@property (nonatomic, strong) SeasoningManagementDeviceModel *selectedDevice;

@end

@implementation SeasoningManagementVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"辅料管理";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫描" style:UIBarButtonItemStyleDone target:self action:@selector(tryToScan)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[SeasoningManagementFirstCell class] forCellReuseIdentifier:SeasoningManagementFirstCell.cellIdentifier];
    [self.tableView registerClass:[SeasoningManagementSecondCell class] forCellReuseIdentifier:SeasoningManagementSecondCell.cellIdentifier];
    [self.tableView registerClass:[MaintenanceEditInputSelectionCell class] forCellReuseIdentifier:MaintenanceEditInputSelectionCell.cellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
    _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnConfirm setTitle:@"上料" forState:UIControlStateNormal];
    [_btnConfirm setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
    [_btnConfirm addTarget:self action:@selector(btnConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnConfirm];
    [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self getDataFromServer];
}

#pragma mark gestures

- (void)btnConfirmClicked {
    WS(weakSelf)
    [GlobalTool popAlertWithTitle:@"确定操作？" message:nil yesStr:@"确定" yesActionBlock:^{
        [weakSelf realSubmitAction];
    }];
}

- (void)realSubmitAction {
    [SVProgressHUD show];
    
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:SEASONNING_MANAGEMENT_ACTION_SHANGLIAO parameters:@{} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"SEASONNING_MANAGEMENT_ACTION_SHANGLIAO: %@", responseJson);
    }];
}

#pragma mark network

- (void)getDataFromServer {
    WS(weakSelf)
    // 查询工程集合
    [[EESHttpDigger sharedInstance] postWithUri:SEASONNING_MANAGEMENT_GET_PROJECT_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"SEASONNING_MANAGEMENT_GET_PROJECT_LIST: %@", responseJson);
        weakSelf.arrOfProject = [SeasoningManagementProjectModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
    }];
    
    // 查询机型集合
    [[EESHttpDigger sharedInstance] postWithUri:SEASONNING_MANAGEMENT_GET_JIXING_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"SEASONNING_MANAGEMENT_GET_JIXING_LIST: %@", responseJson);
        weakSelf.arrOfJixing = [SeasoningManagementJixingModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
    }];
    
    // 查询设备集合
    [[EESHttpDigger sharedInstance] postWithUri:SEASONNING_MANAGEMENT_GET_DEVICE_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"SEASONNING_MANAGEMENT_GET_DEVICE_LIST: %@", responseJson);
        weakSelf.arrOfDevice = [SeasoningManagementDeviceModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
    }];
}

- (void)loadDetailByBarcode {
    if (self.barcodeConntent.length == 0) {
        return;
    }
    
    [SVProgressHUD show];
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:SEASONNING_MANAGEMENT_GET_DETAIL_BY_BARCODE parameters:@{@"asCode":self.barcodeConntent} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"SEASONNING_MANAGEMENT_GET_DETAIL_BY_BARCODE: %@", responseJson);
        [SVProgressHUD dismiss];
        weakSelf.detailData = [SeasoningManagementDetailModel mj_objectWithKeyValues:responseJson[@"Extend"]];
        
        if ([weakSelf.detailData.ASStatus isEqualToString:@"未使用"]) {
            [weakSelf.btnConfirm setTitle:@"上料" forState:UIControlStateNormal];
        } else {
            [weakSelf.btnConfirm setTitle:@"下料" forState:UIControlStateNormal];
        }
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark actions

- (void)tryToScan {
    WS(weakSelf)
    AlertActionBlock block1 = ^(void) {
        [weakSelf scan:0];
    };
    AlertActionBlock block2 = ^(void) {
        [weakSelf scan:1];
    };
    [GlobalTool popSheetAlertWithTitle:@"选择扫码类型" message:nil optionsStrings:@[@"一维码", @"二维码"] yesActionBlocks:@[block1, block2]];
}

- (void)scan:(NSInteger)index {
    SeasoningManagementScanBarcodeVC *vc = [[SeasoningManagementScanBarcodeVC alloc] init];
    
    if (index == 0) {
        vc.isQRCode = NO;
    } else {
        vc.isQRCode = YES;
    }
    
    WS(weakSelf)
    vc.bacodeFoundBlock = ^(NSString * _Nonnull bacodeContent) {
        weakSelf.barcodeConntent = bacodeContent;
        [weakSelf loadDetailByBarcode];
    };
    
    [self pushVC:vc];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    if (indexPath.section == 1) {
        NSMutableArray *arrOfSelectionTitle = [NSMutableArray array];
        
        if (indexPath.row == 0) {
            for (SeasoningManagementProjectModel *m in self.arrOfProject) {
                [arrOfSelectionTitle addObject:m.ProcessName];
            }
        } else if (indexPath.row == 1) {
            for (SeasoningManagementJixingModel *m in self.arrOfJixing) {
                [arrOfSelectionTitle addObject:m.ProductName];
            }
        } else if (indexPath.row == 2) {
            for (SeasoningManagementDeviceModel *m in self.arrOfDevice) {
                [arrOfSelectionTitle addObject:m.EquipName];
            }
        }
        
        ProblemAnswerSelectionVC *vcOfAnswerSelection = [[ProblemAnswerSelectionVC alloc] init];
        vcOfAnswerSelection.arrOfData = arrOfSelectionTitle;
        WS(weakSelf)
        vcOfAnswerSelection.confirmationBlock = ^(NSInteger index, NSString * _Nonnull title) {
            MaintenanceEditInputSelectionCell *selectionCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectionCell setContent:title];
            
            if (indexPath.row == 0) {
                weakSelf.selectedProject = [weakSelf.arrOfProject objectAtIndex:index];
            } else if (indexPath.row == 1) {
                weakSelf.selectedJixing = [weakSelf.arrOfJixing objectAtIndex:index];
            } else if (indexPath.row == 2) {
                weakSelf.selectedDevice = [weakSelf.arrOfDevice objectAtIndex:index];
            }
        };
        [self presentViewController:vcOfAnswerSelection animated:NO completion:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 60;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SeasoningManagementFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:SeasoningManagementFirstCell.cellIdentifier forIndexPath:indexPath];
        
        [cell resetSubviewsWithData:self.detailData];
        
        return cell;
    } else {
        MaintenanceEditInputSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:MaintenanceEditInputSelectionCell.cellIdentifier forIndexPath:indexPath];
        
        [cell showInputArea:(self.detailData != nil)];
        
        if (indexPath.row == 0) {
            [cell resetTitle:@"上料工程："];
        } else if (indexPath.row == 1) {
            [cell resetTitle:@"上料机型："];
        } else {
            [cell resetTitle:@"上料设备："];
        }
        
        return cell;
    }
}

@end
