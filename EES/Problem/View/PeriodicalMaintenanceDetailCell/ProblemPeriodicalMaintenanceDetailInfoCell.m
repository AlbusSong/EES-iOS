//
//  ProblemPeriodicalMaintenanceDetailInfoCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemPeriodicalMaintenanceDetailInfoCell.h"

@interface ProblemPeriodicalMaintenanceDetailInfoCell ()

@property (nonatomic, strong) UIView *grayLine;

@property (nonatomic, strong) UILabel *txtOfInfo1;

@property (nonatomic, strong) UILabel *txtOfStatus;

@property (nonatomic, strong) UILabel *txtOfInfo2;

@property (nonatomic, strong) UILabel *txtOfInfo3;

@property (nonatomic, strong) UILabel *txtOfInfo4;

@property (nonatomic, strong) UILabel *txtOfInfo5;

@property (nonatomic, strong) UILabel *txtOfInfo6;

@property (nonatomic, strong) UILabel *txtOfInfo7;

@property (nonatomic, strong) UILabel *txtOfInfo8;

@end

@implementation ProblemPeriodicalMaintenanceDetailInfoCell

- (void)initSubviews {
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    self.txtOfInfo1 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:16] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    self.txtOfInfo1.text = @"产线名称：上法兰线";
    
    self.txtOfInfo2 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo1.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfInfo2.text = @"计划日期：2019-11-16";
    
    self.txtOfStatus = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfStatus.textAlignment = NSTextAlignmentRight;
    self.txtOfStatus.adjustsFontSizeToFitWidth = YES;
    [self.txtOfStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfInfo2);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.txtOfInfo2.mas_right).offset(3);
    }];
    self.txtOfStatus.text = @"状态：待进行";
    
    self.txtOfInfo3 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo2.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    self.txtOfInfo3.text = @"保养类型：保全保养";
    
    self.txtOfInfo4 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo3.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    self.txtOfInfo4.text = @"保养项目：确保电机旋转正常";
    
    self.txtOfInfo5 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo4.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    self.txtOfInfo5.text = @"保养方法：目视有无裂痕，按压张紧度是否正常，异常时更换";
    
    self.txtOfInfo6 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo5.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    self.txtOfInfo6.text = @"保养内容：确保电机旋转正常";
    
    self.txtOfInfo7 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo6.mas_bottom).offset(5);
        make.right.offset(-10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfInfo7.text = @"保养标准：皮带完好张紧度合适";
    
    self.txtOfInfo8 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo7.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
        make.bottom.offset(-20);
    }];
    self.txtOfInfo8.text = @"实际日期：";
}

@end
