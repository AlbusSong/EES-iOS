//
//  ProblemPeriodicalMaintenanceItemCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemPeriodicalMaintenanceItemCell.h"
#import "PeriodicalMaintenanceItemModel.h"

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
    
    
    self.txtOfGongdan = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfGongdan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfTitle.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    
    
    self.txtOfChanxian = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfChanxian.textAlignment = NSTextAlignmentRight;
    self.txtOfChanxian.adjustsFontSizeToFitWidth = YES;
    [self.txtOfChanxian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfGongdan);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.txtOfGongdan.mas_right).offset(3);
    }];
    
    
    self.txtOfGongdanjihuari = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfGongdanjihuari mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfGongdan);
        make.top.equalTo(self.txtOfGongdan.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    
    
    self.txtOfStatus = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfStatus.textAlignment = NSTextAlignmentRight;
    self.txtOfStatus.adjustsFontSizeToFitWidth = YES;
    [self.txtOfStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfGongdanjihuari);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.txtOfGongdanjihuari.mas_right).offset(3);
    }];
    
    
    self.txtOfBaoyangxiangmu = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfBaoyangxiangmu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfStatus.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.offset(-10);
    }];
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)resetSubviewsWithData:(PeriodicalMaintenanceItemModel *)data {
    self.txtOfTitle.text = [NSString stringWithFormat:@"%@|%@", data.EquipCode, data.EquipName];
    
    self.txtOfGongdan.text = [NSString stringWithFormat:@"工单：%@", data.PMWorkOrderNo];
    
    self.txtOfChanxian.text = [NSString stringWithFormat:@"产线：%@", data.LineName];
    
    self.txtOfGongdanjihuari.text = [NSString stringWithFormat:@"工单计划日：%@", data.PlanDate];
    
    self.txtOfStatus.text = [NSString stringWithFormat:@"状态：%@", data.WorkOrderState1];
    
    self.txtOfBaoyangxiangmu.text = [NSString stringWithFormat:@"保养项目：%@", data.Item];
}

@end
