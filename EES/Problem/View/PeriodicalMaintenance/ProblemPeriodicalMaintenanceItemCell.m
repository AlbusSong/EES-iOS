//
//  ProblemPeriodicalMaintenanceItemCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemPeriodicalMaintenanceItemCell.h"

@interface ProblemPeriodicalMaintenanceItemCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UILabel *txtOfGongdan;

@property (nonatomic, strong) UILabel *txtOfChanxian;

@property (nonatomic, strong) UILabel *txtOfGongdanjihuari;

@property (nonatomic, strong) UILabel *txtOfStatus;

@property (nonatomic, strong) UILabel *txtOfBaoyangxiangmu;

@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemPeriodicalMaintenanceItemCell

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
    
    self.txtOfChanxian = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfChanxian.textAlignment = NSTextAlignmentRight;
    self.txtOfChanxian.adjustsFontSizeToFitWidth = YES;
    [self.txtOfChanxian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfGongdan);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.txtOfGongdan.mas_right).offset(3);
    }];
    self.txtOfChanxian.text = @"产线：上法兰线";
    
    self.txtOfGongdanjihuari = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfGongdanjihuari mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfGongdan);
        make.top.equalTo(self.txtOfGongdan.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfGongdanjihuari.text = @"工单计划日：2019-11-15";
    
    self.txtOfStatus = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfStatus.textAlignment = NSTextAlignmentRight;
    self.txtOfStatus.adjustsFontSizeToFitWidth = YES;
    [self.txtOfStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfGongdanjihuari);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.txtOfGongdanjihuari.mas_right).offset(3);
    }];
    self.txtOfStatus.text = @"状态：维修中";
    
    self.txtOfBaoyangxiangmu = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfBaoyangxiangmu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfStatus.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.offset(-10);
    }];
    self.txtOfBaoyangxiangmu.text = @"保养项目：确保电机旋转正常";
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

@end
