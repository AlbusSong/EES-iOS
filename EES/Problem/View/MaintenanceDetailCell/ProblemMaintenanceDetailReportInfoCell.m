//
//  ProblemMaintenanceDetailReportInfoCell.m
//  EES
//
//  Created by Albus on 2019-11-20.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceDetailReportInfoCell.h"

@interface ProblemMaintenanceDetailReportInfoCell ()

@property (nonatomic, strong) UIView *grayLine;

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UILabel *txtOfChanxian;

@property (nonatomic, strong) UILabel *txtOfType;

@property (nonatomic, strong) UILabel *txtOfBaoxiu;

@property (nonatomic, strong) UILabel *txtOfBaoxiuren;

@property (nonatomic, strong) UILabel *txtOfXianxiang;

@end

@implementation ProblemMaintenanceDetailReportInfoCell

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
    self.txtOfTitle.text = @"【报修信息】";
    
    self.txtOfChanxian = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfChanxian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfTitle.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfChanxian.text = @"产线：上法兰线";
    
    self.txtOfType = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfType.textAlignment = NSTextAlignmentRight;
    self.txtOfType.adjustsFontSizeToFitWidth = YES;
    [self.txtOfType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfChanxian);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.txtOfChanxian.mas_right).offset(3);
    }];
    self.txtOfType.text = @"类型：机械";
    
    self.txtOfType = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfChanxian);
        make.top.equalTo(self.txtOfChanxian.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfType.text = @"报修：11/11 08:33";
    
    self.txtOfBaoxiuren = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfBaoxiuren.textAlignment = NSTextAlignmentRight;
    self.txtOfBaoxiuren.adjustsFontSizeToFitWidth = YES;
    [self.txtOfBaoxiuren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfType);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.txtOfType);
        make.left.equalTo(self.txtOfType.mas_right).offset(3);
    }];
    self.txtOfBaoxiuren.text = @"报修人：彭金华";
    
    self.txtOfXianxiang = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfXianxiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfType);
        make.top.equalTo(self.txtOfType.mas_bottom).offset(0);
        make.right.offset(-10);
        make.height.mas_greaterThanOrEqualTo(21);
        make.bottom.offset(-10);
    }];
    self.txtOfXianxiang.text = @"现象：X轴绝对位置消失";
}

@end
