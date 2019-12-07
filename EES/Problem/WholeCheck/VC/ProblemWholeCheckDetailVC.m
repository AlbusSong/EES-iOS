//
//  ProblemWholeCheckDetailVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckDetailVC.h"
#import "ProblemWholeCheckDetailItemCell.h"

#import "ProblemWholeCheckSubmitVC.h"

#import "WholeCheckItemModel.h"
#import "WholeCheckDetailItemModel.h"

@interface ProblemWholeCheckDetailVC ()

@end

@implementation ProblemWholeCheckDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[ProblemWholeCheckDetailItemCell class] forCellReuseIdentifier:ProblemWholeCheckDetailItemCell.cellIdentifier];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    WS(weakSelf)
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict setValue:self.data.CMAPlanNo forKey:@"cmaPlanNo"];
    [mDict setValue:self.data.CMAWorkOrderNo forKey:@"cmaWorkOrderNo"];
    if (self.state == 0) {
        [mDict setValue:@"P" forKey:@"State"];
    } else if (self.state == 1) {
        [mDict setValue:@"W" forKey:@"State"];
    } else if (self.state == 2) {
        [mDict setValue:@"D" forKey:@"State"];
    }
    
    [[EESHttpDigger sharedInstance] postWithUri:WHOLE_CHECK_GET_DETAIL_ITEM_LIST parameters:mDict shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD dismiss];
        NSLog(@"WHOLE_CHECK_GET_DETAIL_ITEM_LIST: %@", responseJson);
        weakSelf.arrOfData = [WholeCheckDetailItemModel mj_objectArrayWithKeyValuesArray:responseJson[@"Extend"]];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ProblemWholeCheckSubmitVC *vc = [[ProblemWholeCheckSubmitVC alloc] init];
    vc.data = self.arrOfData[indexPath.row];
    vc.state = self.state;
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
    ProblemWholeCheckDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemWholeCheckDetailItemCell.cellIdentifier forIndexPath:indexPath];
    
    [cell resetSubviewsWithData:[self.arrOfData objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
