//
//  ProblemMaintenancePlanDetailTitleCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenancePlanDetailTitleCell.h"

@interface ProblemMaintenancePlanDetailTitleCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@end

@implementation ProblemMaintenancePlanDetailTitleCell

- (void)initSubviews {
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:18] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(25);
        make.left.offset(10);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    self.txtOfTitle.text = @"设备：GDWYJ0J09409|上法蓝内圆磨床#";
}

@end
