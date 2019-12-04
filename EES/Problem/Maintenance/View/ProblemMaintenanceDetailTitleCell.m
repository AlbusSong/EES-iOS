//
//  ProblemMaintenanceDetailTitleCell.m
//  EES
//
//  Created by Albus on 2019-11-20.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceDetailTitleCell.h"
#import "MaintenanceDetailModel.h"

@interface ProblemMaintenanceDetailTitleCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@end

@implementation ProblemMaintenanceDetailTitleCell

- (void)initSubviews {
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:18] textColor:HexColor(MAIN_COLOR) parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(25);
        make.left.offset(10);
        make.right.offset(-10);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    
}

- (void)resetSubviewsWithData:(MaintenanceDetailModel *)data {
    self.txtOfTitle.text = [NSString stringWithFormat:@"设备：%@|%@", data.EquipCode, data.EquipName];
}

@end
