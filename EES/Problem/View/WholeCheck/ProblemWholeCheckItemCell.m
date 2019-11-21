//
//  ProblemWholeCheckItemCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckItemCell.h"

@interface ProblemWholeCheckItemCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UILabel *txtOfGongdan;

@property (nonatomic, strong) UILabel *txtOfTime;

@property (nonatomic, strong) UILabel *txtOfType;

@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemWholeCheckItemCell

- (void)initSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:17] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(7);
        make.left.offset(10);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(23);
    }];
    self.txtOfTitle.text = @"GDWY4H09201|压缩机称重设备";
    
    self.txtOfGongdan = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfGongdan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfTitle.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfGongdan.text = @"工单：BMPO2019112043";
    
    self.txtOfTime = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfGongdan);
        make.top.equalTo(self.txtOfGongdan.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfTime.text = @"点检时间：11月16日";
    
    self.txtOfType = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfTime.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.offset(-10);
    }];
    self.txtOfType.text = @"点检类型：基本点检";
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

@end
