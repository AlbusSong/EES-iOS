//
//  ProblemNewReportVC.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemNewReportVC.h"
#import "ProblemNewReportSelectionCell.h"
#import "ProblemNewReportContentCell.h"

#import "ProblemAnswerSelectionVC.h"

#import "NewReportChanxianModel.h"
#import "NewReportShebeiModel.h"
#import "NewReportWeihuJuesheModel.h"
#import "NewReportProblemLevelModel.h"
#import "NewReportProblemDescModel.h"

@interface ProblemNewReportVC () <ProblemNewReportContentCellDelegate>

@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic, copy) NSArray *arrOfChanxian;
@property (nonatomic, strong) NewReportChanxianModel *selectedChanxian;

@property (nonatomic, copy) NSArray *arrOfShebei;
@property (nonatomic, strong) NewReportShebeiModel *selectedShebei;

@property (nonatomic, copy) NSArray *arrOfGuzhangleixing;
@property (nonatomic, copy) NSDictionary *selectedGuzhangleixing;

@property (nonatomic, copy) NSArray *arrOfWeihuJueshe;
@property (nonatomic, strong) NewReportWeihuJuesheModel *selectedWeihuJueshe;

@property (nonatomic, copy) NSArray *arrOfProblemLevel;
@property (nonatomic, strong) NewReportProblemLevelModel *selectedProblemLevel;

@property (nonatomic, copy) NSArray *arrOfProblemDesc;
@property (nonatomic, strong) NewReportProblemDescModel *selectedProblemDesc;


@property (nonatomic, copy) NSString *problemContent;


@property (nonatomic, copy) NSArray *arrOfTitle;

@end

@implementation ProblemNewReportVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"故障报修";
        
        self.selectedIndex = -1;
        self.arrOfTitle = @[@"产线", @"设备", @"故障类型", @"维护角色", @"故障等级", @"故障现象代码"];
        self.arrOfGuzhangleixing = @[@{@"value":@"ELE", @"title":@"电气"}, @{@"value":@"MEC", @"title":@"机械"}, @{@"value":@"ACC", @"title":@"品质"}];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[ProblemNewReportSelectionCell class] forCellReuseIdentifier:ProblemNewReportSelectionCell.cellIdentifier];
    [self.tableView registerClass:[ProblemNewReportContentCell class] forCellReuseIdentifier:ProblemNewReportContentCell.cellIdentifier];
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
}

#pragma mark gestures

- (void)btnSubmitClicked {
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
//    [mDict setValue: forKey:@"bmtype"];
}

#pragma mark network

- (void)getDataFromServer {
    
    WS(weakSelf)
    
    // 产线
    [[EESHttpDigger sharedInstance] postWithUri:PROBLEM_REPORT_CHANXIAN_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"PROBLEM_REPORT_CHANXIAN_LIST: %@", responseJson);
        NSArray *extend = responseJson[@"Extend"];
        weakSelf.arrOfChanxian = [NewReportChanxianModel mj_objectArrayWithKeyValuesArray:extend];
    }];
    
    // 报修呼叫-加载设备
    [[EESHttpDigger sharedInstance] postWithUri:GET_DEVICE_LIST parameters:@{@"linecode":@""} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"GET_DEVICE_LIST: %@", responseJson);
        NSArray *extend = responseJson[@"Extend"];
        weakSelf.arrOfShebei = [NewReportShebeiModel mj_objectArrayWithKeyValuesArray:extend];
        NSLog(@"arrOfShebei: %@", weakSelf.arrOfShebei);
    }];
    
    
    // 报修呼叫-加载维修角色
    [[EESHttpDigger sharedInstance] postWithUri:GET_MAINTENANCE_ROLE_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"GET_MAINTENANCE_ROLE_LIST: %@", responseJson);
        NSArray *extend = responseJson[@"Extend"];
        weakSelf.arrOfWeihuJueshe = [NewReportWeihuJuesheModel mj_objectArrayWithKeyValuesArray:extend];
    }];
    
    // 报修呼叫-加载故障等级
    [[EESHttpDigger sharedInstance] postWithUri:GET_PROBLEM_LEVEL_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"GET_PROBLEM_LEVEL_LIST: %@", responseJson);
        NSArray *extend = responseJson[@"Extend"];
        weakSelf.arrOfProblemLevel = [NewReportProblemLevelModel mj_objectArrayWithKeyValuesArray:extend];
    }];
    
    // 报修呼叫-加载故障现象代码
    [[EESHttpDigger sharedInstance] postWithUri:GET_PROBLEM_DESC_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"GET_PROBLEM_DESC_LIST: %@", responseJson);
        NSArray *extend = responseJson[@"Extend"];
        weakSelf.arrOfProblemDesc = [NewReportProblemDescModel mj_objectArrayWithKeyValuesArray:extend];
    }];
}

#pragma mark private actions

- (void)unhighlightSelectedCell {
    if (self.selectedIndex < 6) {
        ProblemNewReportSelectionCell *cell = (ProblemNewReportSelectionCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
        [cell showHilighted:NO];
    } else {
        
    }
}

- (void)fillAnswerForSelectedCellByAnswer:(NSString *)answer {
    if (self.selectedIndex < 6) {
        ProblemNewReportSelectionCell *cell = (ProblemNewReportSelectionCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
        [cell setContent:answer];
        [cell showHilighted:NO];
    } else {
        
    }
}

- (NSArray *)generateSelectionTitlesBy:(NSArray *)sourceModelArray {
    NSMutableArray *arrOfSelectionTitle = [NSMutableArray array];
    
//    for ()
    
    return (NSArray *)arrOfSelectionTitle;
}


#pragma mark ProblemNewReportContentCellDelegate

- (void)contentHasChangedTo:(NSString *)newContent {
    self.problemContent = newContent;
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.selectedIndex != 6) {
        [self.view endEditing:YES];
    }
    
    self.selectedIndex = indexPath.row;
    
    ProblemNewReportSelectionCell *cell = (ProblemNewReportSelectionCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell showHilighted:YES];
    
    NSMutableArray *arrOfSelectionTitle = [NSMutableArray array];
    
    if (self.selectedIndex == 0) {
        for (NewReportChanxianModel *m in self.arrOfChanxian) {
            NSString *title = [NSString stringWithFormat:@"%@|%@", m.LineCode, m.LineName];
            [arrOfSelectionTitle addObject:title];
        }
    } else if (self.selectedIndex == 1) {
        for (NewReportShebeiModel *m in self.arrOfShebei) {
//            [arrOfSelectionTitle addObject:m];
        }
    } else if (self.selectedIndex == 2) {
        for (NSDictionary *dict in self.arrOfGuzhangleixing) {
            [arrOfSelectionTitle addObject:dict[@"title"]];
        }
    } else if (self.selectedIndex == 3) {
        for (NewReportWeihuJuesheModel *m in self.arrOfWeihuJueshe) {
            [arrOfSelectionTitle addObject:m.Name];
        }
    } else if (self.selectedIndex == 4) {
        for (NewReportProblemLevelModel *m in self.arrOfProblemLevel) {
            [arrOfSelectionTitle addObject:m.Remark];
        }
    } else if (self.selectedIndex == 5) {
        for (NewReportProblemDescModel *m in self.arrOfProblemDesc) {
            [arrOfSelectionTitle addObject:m.BMTypeName];
        }
    }
    
    if (self.selectedIndex < 6) {
        
        ProblemAnswerSelectionVC *vcOfAnswerSelection = [[ProblemAnswerSelectionVC alloc] init];
        vcOfAnswerSelection.arrOfData = arrOfSelectionTitle;
        WS(weakSelf)
        vcOfAnswerSelection.cancelBlock = ^{
            [weakSelf unhighlightSelectedCell];
        };
        vcOfAnswerSelection.confirmationBlock = ^(NSInteger index, NSString * _Nonnull title) {
            [weakSelf fillAnswerForSelectedCellByAnswer:title];
            if (weakSelf.selectedIndex == 0) {
                weakSelf.selectedChanxian = [weakSelf.arrOfChanxian objectAtIndex:index];
            } else if (weakSelf.selectedIndex == 1) {
                weakSelf.selectedShebei = [weakSelf.arrOfShebei objectAtIndex:index];
            } else if (weakSelf.selectedIndex == 2) {
                weakSelf.selectedGuzhangleixing = [weakSelf.arrOfGuzhangleixing objectAtIndex:index];
            } else if (weakSelf.selectedIndex == 3) {
                weakSelf.selectedWeihuJueshe = [weakSelf.arrOfWeihuJueshe objectAtIndex:index];
            } else if (weakSelf.selectedIndex == 4) {
                weakSelf.selectedProblemLevel = [weakSelf.arrOfProblemLevel objectAtIndex:index];
            } else if (weakSelf.selectedIndex == 5) {
                weakSelf.selectedProblemDesc = [weakSelf.arrOfProblemDesc objectAtIndex:index];
            }
        };
        [self presentViewController:vcOfAnswerSelection animated:NO completion:nil];
        
    } else {
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 6) {
        return 140;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 6) {
        ProblemNewReportSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportSelectionCell.cellIdentifier forIndexPath:indexPath];
        
        [cell resetTitle:[self.arrOfTitle objectAtIndex:indexPath.row]];
        
        return cell;
    } else {
        ProblemNewReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportContentCell.cellIdentifier forIndexPath:indexPath];
        
        cell.delegate = self;
        
        [cell resetTitle:@"故障现象代码"];
        
        return cell;
    }
}

@end
