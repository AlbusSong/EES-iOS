//
//  ProblemMaintenanceDetailInfoCell.m
//  EES
//
//  Created by Albus on 2019-11-20.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceDetailInfoCell.h"

@interface ProblemMaintenanceDetailInfoCell ()

@property (nonatomic, strong) UIView *grayLine;

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UILabel *txtOfInfo1;

@property (nonatomic, strong) UILabel *txtOfInfo2;

@property (nonatomic, strong) UILabel *txtOfInfo3;

@property (nonatomic, strong) UILabel *txtOfInfo4;

@property (nonatomic, strong) UILabel *txtOfInfo5;

@property (nonatomic, strong) UILabel *txtOfInfo6;

@property (nonatomic, strong) UILabel *txtOfInfo7;

@property (nonatomic, strong) UILabel *txtOfInfo8;

@end

@implementation ProblemMaintenanceDetailInfoCell

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
    }];
    self.txtOfTitle.text = @"【维修信息】";
    
    self.txtOfInfo1 = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfTitle.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfInfo1.text = @"工单编号：BMPO2019112043";
    
    self.txtOfInfo2 = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfInfo1.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfInfo2.text = @"工单状态：维修中";
    
    self.txtOfInfo3 = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfInfo2.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfInfo3.text = @"开始时间：2019/11/11 13:39";
    
    self.txtOfInfo4 = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfInfo3.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfInfo4.text = @"故障等级：保全员上报";
    
    self.txtOfInfo5 = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfInfo4.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfInfo5.text = @"维修角色：保全员";
    
    self.txtOfInfo6 = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfInfo5.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfInfo6.text = @"委外状态：";
    
    self.txtOfInfo7 = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfInfo6.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfInfo7.text = @"是否驳回：";
    
    self.txtOfInfo8 = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfInfo7.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
        make.bottom.offset(-10);
    }];
    self.txtOfInfo8.text = @"驳回原因：";
}

@end
