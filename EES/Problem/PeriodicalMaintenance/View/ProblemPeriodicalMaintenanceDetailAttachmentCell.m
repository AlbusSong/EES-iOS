//
//  ProblemPeriodicalMaintenanceDetailAttachmentCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemPeriodicalMaintenanceDetailAttachmentCell.h"

@interface ProblemPeriodicalMaintenanceDetailAttachmentCell ()

@property (nonatomic, strong) UIView *grayLine;

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UILabel *txtOfInfo1;

@end

@implementation ProblemPeriodicalMaintenanceDetailAttachmentCell

- (void)initSubviews {
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:18] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.left.offset(10);
        make.top.offset(10);
        make.bottom.offset(-50);
    }];
    self.txtOfTitle.text = @"保养附件";
    
//    self.txtOfInfo1 = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
//    [self.txtOfInfo1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.txtOfTitle);
//        make.top.equalTo(self.txtOfTitle.mas_bottom).offset(0);
//        make.height.mas_equalTo(21);
//    }];
//    self.txtOfInfo1.text = @"工单编号：BMPO2019112043";
}

@end
