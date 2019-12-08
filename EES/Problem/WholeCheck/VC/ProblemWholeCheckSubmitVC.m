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
#import "WholeCheckDetailItemDetailModel.h"

@interface ProblemWholeCheckSubmitVC () <ProblemNewReportContentCellDelegate, ProblemWholeCheckSubmitAttachmentCellDelegate>

@property (nonatomic, strong) WholeCheckDetailItemDetailModel *detailData;

@property (nonatomic, copy) NSString *attachmentInfo;

@property (nonatomic, copy) NSString *exceptionComment;

@property (nonatomic, copy) NSString *phenomenon;

@property (nonatomic, copy) NSString *strategy;

@property (nonatomic, copy) NSString *imageLocalPath;

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
        [btnConfirm addTarget:self action:@selector(btnConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnConfirm];
        [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(self.view);
            make.right.mas_equalTo(self.view).offset(0);
            make.height.mas_equalTo(50);
        }];
    }
    
    [self getDataFromServer];
}

#pragma mark gestures

- (void)btnConfirmClicked {
    if (self.state == 0) {
        
    } else if (self.state == 2) {
        if (self.exceptionComment.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请填写异常处理备注"];
            return;
        }
        
        NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
        [mDict setValue:self.data.WorkOrderNoApp forKey:@"cmaWorkOrderNo"];
        [mDict setValue:self.detailData.CMAProjectNo forKey:@"cmaProjectNo"];
        [mDict setValue:self.exceptionComment forKey:@"Comment"];
        
        [SVProgressHUD show];
        WS(weakSelf)
        [[EESHttpDigger sharedInstance] postWithUri:WHOLE_CHECK_ACTION_SUBMIT_EXCEPTION_CONTENT parameters:mDict success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
            NSLog(@"WHOLE_CHECK_ACTION_SUBMIT_EXCEPTION_CONTENT: %@", responseJson);
            if (code == 0) {
                [SVProgressHUD showInfoWithStatus:message];
                return ;
            }
            
            [SVProgressHUD showInfoWithStatus:@"提交成功"];
            [weakSelf back];
        }];
    }
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:WHOLE_CHECK_GET_DETAIL_ITEM_DETIAL parameters:@{@"cmaProjectNo":self.data.CMAProjectNo} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"WHOLE_CHECK_GET_DETAIL_ITEM_DETIAL: %@", responseJson);
        [SVProgressHUD dismiss];
        weakSelf.detailData = [WholeCheckDetailItemDetailModel mj_objectWithKeyValues:responseJson];
        [weakSelf.tableView reloadData];
    }];
    
    [[EESHttpDigger sharedInstance] postWithUri:WHOLE_CHECK_GET_DETAIL_ATTACHMENT_INFO parameters:@{@"projectNo":self.data.CMAProjectNo, @"Type":@"CMA"} success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"WHOLE_CHECK_GET_DETAIL_ATTACHMENT_INFO: %@", responseJson);
        weakSelf.attachmentInfo = responseJson[@"Extend"];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark ProblemNewReportContentCellDelegate

- (void)contentHasChangedTo:(NSString *)newContent atIndexPath:(NSIndexPath *)indexPath {
    if (self.state == 0) {
        if (indexPath.row == 1) {
            self.phenomenon = newContent;
        } else if (indexPath.row == 2) {
            self.strategy = newContent;
        }
    } else if (self.state == 2) {
        self.exceptionComment = newContent;
    }
}

#pragma mark ProblemWholeCheckSubmitAttachmentCellDelegate

- (void)tryToChooseFile {
    WS(weakSelf)
    [[PhotoObtainingTool sharedInstance] choosePhotoWithType:UIImagePickerControllerSourceTypePhotoLibrary completionHandler:^(NSString * _Nonnull imageLocalPath) {
        NSLog(@"imageLocalPath: %@", imageLocalPath);
        weakSelf.imageLocalPath = imageLocalPath;
        
        [weakSelf tryToUploadFile:imageLocalPath];
    }];
}

- (void)tryToUploadFile:(NSString *)imageLocalPath {
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict setValue:self.data.WorkOrderNoApp forKey:@"cmaProjectNo"];
    [mDict setValue:self.detailData.CMAProjectNo forKey:@"cmaProjectNo"];
    [mDict setValue:@"CMAPP" forKey:@"doctype"];
    NSData *data = [NSData dataWithContentsOfFile:imageLocalPath];
    [mDict setValue:[data base64EncodedStringWithOptions:0] forKey:@"Picture"];
    [[EESHttpDigger sharedInstance] postWithUri:WHOLE_CHECK_ACTION_UPLOAD_FILE parameters:mDict success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"WHOLE_CHECK_ACTION_UPLOAD_FILE: %@", responseJson);
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
            
            [cell resetSubviewsWithTitle:[NSString stringWithFormat:@"项目：%@", AVOIDNULL(self.detailData.Project)]];
            
            return cell;
        } else {
            ProblemWholeCheckSubmitInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemWholeCheckSubmitInfoCell.cellIdentifier forIndexPath:indexPath];
            
            [cell resetSubviewsWithData:self.detailData];
            [cell resetAttachmentInfo:self.attachmentInfo];
            [cell showPhenomenonAndStrategy:(self.state != 0)];
            
            return cell;
        }
    } else {
        if (self.state == 0) {
            if (indexPath.row == 0) {
                ProblemWholeCheckSubmitSegmentControlCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemWholeCheckSubmitSegmentControlCell.cellIdentifier forIndexPath:indexPath];
                
                return cell;
            } else if (indexPath.row == 1) {
                ProblemNewReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportContentCell.cellIdentifier forIndexPath:indexPath];
                cell.delegate = self;
                cell.indexPath = indexPath;
                [cell setPlaceholder:@"现象"];
                
                return cell;
            } else if (indexPath.row == 2) {
                ProblemNewReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportContentCell.cellIdentifier forIndexPath:indexPath];
                cell.delegate = self;
                cell.indexPath = indexPath;
                [cell setPlaceholder:@"对策"];
                
                return cell;
            } else {
                ProblemWholeCheckSubmitAttachmentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemWholeCheckSubmitAttachmentCell.cellIdentifier forIndexPath:indexPath];
                
                cell.delegate = self;
                
                return cell;
            }
        } else if (self.state == 2) {
            ProblemNewReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportContentCell.cellIdentifier forIndexPath:indexPath];
            cell.delegate = self;
            cell.indexPath = indexPath;
            [cell setPlaceholder:@"异常处理备注"];
            
            return cell;
        }
    }
    return [ASTableViewCell new];
}

@end
