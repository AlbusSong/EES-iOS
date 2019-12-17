//
//  ProblemPeriodicalMaintenanceDetailInfoCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemPeriodicalMaintenanceDetailInfoCell.h"
#import "PeriodicalMaintenanceDetailModel.h"

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
    
    
    self.txtOfInfo2 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo1.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    
    self.txtOfStatus = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfStatus.textAlignment = NSTextAlignmentRight;
    self.txtOfStatus.adjustsFontSizeToFitWidth = YES;
    [self.txtOfStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfInfo2);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.txtOfInfo2.mas_right).offset(3);
    }];
    
    self.txtOfInfo3 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo2.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    
    self.txtOfInfo4 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo3.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    
    self.txtOfInfo5 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo4.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    
    self.txtOfInfo6 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo5.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    
    self.txtOfInfo7 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo6.mas_bottom).offset(5);
        make.right.offset(-10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    
    self.txtOfInfo8 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo7.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
        make.bottom.offset(-20);
    }];
}

- (void)resetSubviewsWithData:(PeriodicalMaintenanceDetailModel *)data {
    self.txtOfInfo1.text = [NSString stringWithFormat:@"产线名称：%@", AVOIDNULL(data.LineName)];
    
    self.txtOfInfo2.text = [NSString stringWithFormat:@"计划日期：%@", AVOIDNULL(data.WorkOrderPlanDate1)];
    
    self.txtOfStatus.text = [NSString stringWithFormat:@"状态：%@", AVOIDNULL(data.WorkOrderState1)];
    
    self.txtOfInfo3.text = [NSString stringWithFormat:@"保养类型：%@", AVOIDNULL(data.PMTypeName)];
    
    self.txtOfInfo4.text = [NSString stringWithFormat:@"保养项目：%@", AVOIDNULL(data.Item)];
    
    self.txtOfInfo5.text = [NSString stringWithFormat:@"保养方法：%@", AVOIDNULL(data.Method)];
    
    self.txtOfInfo6.text = [NSString stringWithFormat:@"保养内容：%@", AVOIDNULL(data.Detail)];
    
    self.txtOfInfo7.text = [NSString stringWithFormat:@"保养标准：%@", AVOIDNULL(data.Stardard)];
    
    self.txtOfInfo8.text = [NSString stringWithFormat:@"实际日期：%@", AVOIDNULL(data.WorkOrderStartDate1)];
}

@end
