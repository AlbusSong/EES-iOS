//
//  HomeFunctionModulesVC.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "HomeFunctionModulesVC.h"
#import "HomeFunctionModuleCell.h"

#import "ProblemNewReportVC.h"
#import "ProblemReportListVC.h"
#import "ProblemMaintenanceListVC.h"
#import "ProblemMaintenanceConfirmationListVC.h"
#import "ProblemPeriodicalMaintenanceListVC.h"
#import "ProblemMaintenancePlanListVC.h"
#import "ProblemGroupCheckListVC.h"
#import "ProblemWholeCheckListVC.h"
#import "SeasoningManagementVC.h"

#import "HomeFunctionModuleModel.h"

@interface HomeFunctionModulesVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *clv;

@property (nonatomic, copy) NSArray *arrOfTitle;

@property (nonatomic, strong) HomeFunctionModuleModel *moduleData;

@end

@implementation HomeFunctionModulesVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"设备管理(EES)";
        self.arrOfTitle = @[@"故障报修", @"报修清单", @"维修工单", @"维修确认", @"定期保养", @"计划维修", @"班组点检", @"保全点检", @"辅料管理"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.clv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.clv.clipsToBounds = YES;
    self.clv.backgroundColor = [UIColor clearColor];
    self.clv.delaysContentTouches = NO;
    self.clv.alwaysBounceVertical = YES;
    self.clv.showsHorizontalScrollIndicator = NO;
    self.clv.delegate = self;
    self.clv.dataSource = self;
    [self.clv registerClass:[HomeFunctionModuleCell class] forCellWithReuseIdentifier:HomeFunctionModuleCell.cellIdentifier];
    [self.view addSubview:self.clv];
    [self.clv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    
    [self getDataFromServer];
}

#pragma mark network

- (void)getDataFromServer {
    [SVProgressHUD show];
    WS(weakSelf)
    [[EESHttpDigger sharedInstance] postWithUri:HOME_FUNCTION_MODULES parameters:@{@"tag":@""} shouldCache:YES success:^(int code, NSString * _Nonnull message, id  _Nonnull responseJson) {
        [SVProgressHUD dismiss];
        NSLog(@"HOME_FUNCTION_MODULES: %@", responseJson);
        NSArray *extend = responseJson[@"Extend"];
        if (extend.count == 0) {
            return ;
        }
        
        weakSelf.moduleData = [HomeFunctionModuleModel mj_objectWithKeyValues:extend.firstObject];
        [weakSelf.clv reloadData];
    }];
}

#pragma mark UICollectionViewDelegate, UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        ProblemNewReportVC * vc = [[ProblemNewReportVC alloc] init];
        [self pushVC:vc];
    } else if (indexPath.item == 1) {
        ProblemReportListVC *vc = [[ProblemReportListVC alloc] init];
        [self pushVC:vc];
    } else if (indexPath.item == 2) {
        ProblemMaintenanceListVC *vc = [[ProblemMaintenanceListVC alloc] init];
        [self pushVC:vc];
    } else if (indexPath.item == 3) {
        ProblemMaintenanceConfirmationListVC *vc = [[ProblemMaintenanceConfirmationListVC alloc] init];
        [self pushVC:vc];
    } else if (indexPath.item == 4) {
        ProblemPeriodicalMaintenanceListVC *vc = [[ProblemPeriodicalMaintenanceListVC alloc] init];
        [self pushVC:vc];
    } else if (indexPath.item == 5) {
        ProblemMaintenancePlanListVC *vc = [[ProblemMaintenancePlanListVC alloc] init];
        [self pushVC:vc];
    } else if (indexPath.item == 6) {
        ProblemGroupCheckListVC *vc = [[ProblemGroupCheckListVC alloc] init];
        [self pushVC:vc];
    } else if (indexPath.item == 7) {
        ProblemWholeCheckListVC *vc = [[ProblemWholeCheckListVC alloc] init];
        [self pushVC:vc];
    } else if (indexPath.item == 8) {
        SeasoningManagementVC *vc = [[SeasoningManagementVC alloc] init];
        [self pushVC:vc];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = floorf((ScreenW - 10*2 - 10*2)/3.0);
    return CGSizeMake(width, 100);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(20, 10, 20, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeFunctionModuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeFunctionModuleCell.cellIdentifier forIndexPath:indexPath];
    
    [cell resetSubviewsWithTitle:[self.arrOfTitle objectAtIndex:indexPath.item]];
    
    NSInteger badgeValue = 0;
    if (indexPath.item == 1) {
        badgeValue = self.moduleData.IntCol1;
    } else if (indexPath.item == 2) {
        badgeValue = self.moduleData.IntCol2;
    } else if (indexPath.item == 3) {
           badgeValue = self.moduleData.IntCol3;
    } else if (indexPath.item == 4) {
           badgeValue = self.moduleData.IntCol4;
    } else if (indexPath.item == 5) {
           badgeValue = self.moduleData.IntCol5;
    } else if (indexPath.item == 6) {
           badgeValue = self.moduleData.IntCol6;
    } else if (indexPath.item == 7) {
           badgeValue = self.moduleData.IntCol7;
    } else if (indexPath.item == 8) {
           badgeValue = self.moduleData.IntCol8;
    }
    [cell resetBadgeValue:badgeValue];
    
    return cell;
}

@end
