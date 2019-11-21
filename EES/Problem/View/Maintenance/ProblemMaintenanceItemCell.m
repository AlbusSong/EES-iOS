//
//  ProblemMaintenanceItemCell.m
//  EES
//
//  Created by Albus on 2019-11-20.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceItemCell.h"

@interface ProblemMaintenanceItemCell ()

@property (nonatomic, strong) UILabel *txtOfTime;

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UILabel *txtOfChanxian;

@property (nonatomic, strong) UILabel *txtOfDuration;

@property (nonatomic, strong) UILabel *txtOfOrderNumber;

@property (nonatomic, strong) UILabel *txtOfStatus;

@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemMaintenanceItemCell

- (void)initSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.txtOfTime = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.offset(10);
        make.height.mas_equalTo(21);
    }];
    self.txtOfTime.text = @"16:09";
    
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:17] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.txtOfTime);
        make.left.offset(10);
        make.right.equalTo(self.txtOfTime.mas_left).offset(-5);
    }];
    self.txtOfTitle.text = @"GDWY4H09201|压缩机称重设备";
    
    self.txtOfChanxian = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfChanxian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfTitle.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfChanxian.text = @"产线：上法兰线";
    
    self.txtOfDuration = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfDuration.textAlignment = NSTextAlignmentRight;
    self.txtOfDuration.adjustsFontSizeToFitWidth = YES;
    [self.txtOfDuration mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfChanxian);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.txtOfTime);
        make.left.equalTo(self.txtOfChanxian.mas_right).offset(3);
    }];
    self.txtOfDuration.text = @"耗时：30分钟";
    
    self.txtOfOrderNumber = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfOrderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfChanxian);
        make.top.equalTo(self.txtOfChanxian.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfOrderNumber.text = @"工单：BMPO2019112043";
    
    self.txtOfStatus = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfStatus.textAlignment = NSTextAlignmentRight;
    self.txtOfStatus.adjustsFontSizeToFitWidth = YES;
    [self.txtOfStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfOrderNumber);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.txtOfTime);
        make.left.equalTo(self.txtOfOrderNumber.mas_right).offset(3);
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

@end
