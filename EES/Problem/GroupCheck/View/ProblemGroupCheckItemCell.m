//
//  ProblemGroupCheckItemCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemGroupCheckItemCell.h"
#import "GroupCheckItemModel.h"

@interface ProblemGroupCheckItemCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UILabel *txtOfGongdan;

@property (nonatomic, strong) UILabel *txtOfStartTime;

@property (nonatomic, strong) UILabel *txtOfEndTime;

@property (nonatomic, strong) UILabel *txtOfStatus;

@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemGroupCheckItemCell

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
    
    self.txtOfStartTime = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfStartTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfGongdan);
        make.top.equalTo(self.txtOfGongdan.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfStartTime.text = @"开始时间：08:00";
    
    self.txtOfEndTime = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfEndTime.textAlignment = NSTextAlignmentRight;
    self.txtOfEndTime.adjustsFontSizeToFitWidth = YES;
    [self.txtOfEndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfStartTime);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.txtOfStartTime.mas_right).offset(3);
    }];
    self.txtOfEndTime.text = @"结束时间：12:07";
    
    self.txtOfStatus = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfEndTime.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.offset(-10);
    }];
    self.txtOfStatus.text = @"状态：维修中";
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)resetSubviewsWithData:(GroupCheckItemModel *)data {
    self.txtOfTitle.text = [NSString stringWithFormat:@"%@|%@", data.EquipCode, data.EquipName];
    
    self.txtOfGongdan.text = [NSString stringWithFormat:@"工单：%@", data.CMSWorkOrderNo];
    
    self.txtOfStartTime.text = [NSString stringWithFormat:@"开始时间：%@", data.StartTimeApp];
    
    self.txtOfEndTime.text = [NSString stringWithFormat:@"工结束时间：%@", data.EndTimeApp];
    
    self.txtOfStatus.text = [NSString stringWithFormat:@"状态：%@", data.WorkOrderState];
}

@end
