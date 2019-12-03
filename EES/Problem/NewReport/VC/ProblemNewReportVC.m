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

@interface ProblemNewReportVC ()

@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic, copy) NSArray *arrOfChanxian;

@property (nonatomic, copy) NSArray *arrOfShebei;

@end

@implementation ProblemNewReportVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"故障报修";
        
        self.selectedIndex = -1;
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
    [self.view addSubview:btnSubmit];
    [btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    
    WS(weakSelf)
    
    // 产线
    [[EESHttpDigger sharedInstance] postWithUri:PROBLEM_REPORT_CHANXIAN_LIST parameters:@{} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        NSLog(@"PROBLEM_REPORT_CHANXIAN_LIST: %@", responseJson);
        NSArray *extend = responseJson[@"Extend"];
        weakSelf.arrOfChanxian = [NewReportChanxianModel mj_objectArrayWithKeyValuesArray:extend];
        NSLog(@"arrOfChanxian: %@", weakSelf.arrOfChanxian);
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
    
    if (indexPath.row == 0) {
        for (NewReportChanxianModel *m in self.arrOfChanxian) {
            NSString *title = [NSString stringWithFormat:@"%@|%@", m.LineCode, m.LineName];
            [arrOfSelectionTitle addObject:title];
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
        
        return cell;
    } else {
        ProblemNewReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemNewReportContentCell.cellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
}

@end
