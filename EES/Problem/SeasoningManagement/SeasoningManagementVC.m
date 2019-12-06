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

#import "SeasoningManagementScanBarcodeVC.h"

#import "SeasoningManagementDeviceModel.h"
#import "SeasoningManagementProjectModel.h"
#import "SeasoningManagementJixingModel.h"

@interface SeasoningManagementVC ()

@property (nonatomic, copy) NSString *barcodeConntent;


@property (nonatomic, copy) NSArray *arrOfProject;

@property (nonatomic, copy) NSArray *arrOfJixing;

@property (nonatomic, copy) NSArray *arrOfDevice;

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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnConfirm setTitle:@"上料" forState:UIControlStateNormal];
    [btnConfirm setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
    [self.view addSubview:btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self getDataFromServer];
    
    self.barcodeConntent = @"19004012_201911210001";
    [self loadDetailByBarcode];
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
        [SVProgressHUD dismiss];
        NSLog(@"SEASONNING_MANAGEMENT_GET_DETAIL_BY_BARCODE: %@", responseJson);
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
    
//    ProblemWholeCheckItemVC *vc = [[ProblemWholeCheckItemVC alloc] init];
//    [self pushVC:vc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
//    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SeasoningManagementFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:SeasoningManagementFirstCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    } else {
        SeasoningManagementSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:SeasoningManagementSecondCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
}

@end
