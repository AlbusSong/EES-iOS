//
//  ProblemMaintenanceConfirmationItemCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceConfirmationItemCell.h"

@interface ProblemMaintenanceConfirmationItemCell ()

@property (nonatomic, strong) UIImageView *imgvOfSelection;

@property (nonatomic, strong) UILabel *txtOfTime;

@property (nonatomic, strong) UILabel *txtOfTitle;

// 产线
@property (nonatomic, strong) UILabel *txtOfChanxian;

// 报修
@property (nonatomic, strong) UILabel *txtOfBaogongrenyuan;

// 角色
@property (nonatomic, strong) UILabel *txtOfRole;

// 类型
@property (nonatomic, strong) UILabel *txtOfBaogongshijian;

// 单号
@property (nonatomic, strong) UILabel *txtOfOrderNumber;

// 现象
@property (nonatomic, strong) UILabel *txtOfStrategy;


@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemMaintenanceConfirmationItemCell

- (void)initSubviews {
    self.imgvOfSelection = [[UIImageView alloc] init];
    self.imgvOfSelection.contentMode = UIViewContentModeScaleAspectFit;
    self.imgvOfSelection.backgroundColor = RANDOM_COLOR;
    [self.contentView addSubview:self.imgvOfSelection];
    [self.imgvOfSelection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-8);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(10);
    }];
    
    self.txtOfTime = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgvOfSelection.mas_left).offset(-5);
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
    
    self.txtOfBaogongrenyuan = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfBaogongrenyuan.textAlignment = NSTextAlignmentRight;
    self.txtOfBaogongrenyuan.adjustsFontSizeToFitWidth = YES;
    [self.txtOfBaogongrenyuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfChanxian);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.txtOfTime);
        make.left.equalTo(self.txtOfChanxian.mas_right).offset(3);
    }];
    self.txtOfBaogongrenyuan.text = @"报工人员：张强";
    
    self.txtOfRole = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfRole mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfChanxian);
        make.top.equalTo(self.txtOfChanxian.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfRole.text = @"角色：管理员角色";
    
    self.txtOfBaogongshijian = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfBaogongshijian.textAlignment = NSTextAlignmentRight;
    self.txtOfBaogongshijian.adjustsFontSizeToFitWidth = YES;
    [self.txtOfBaogongshijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfRole);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.txtOfTime);
        make.left.equalTo(self.txtOfRole.mas_right).offset(3);
    }];
    self.txtOfBaogongshijian.text = @"报工时间：17:32";
    
    self.txtOfOrderNumber = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfOrderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfRole);
        make.top.equalTo(self.txtOfRole.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    self.txtOfOrderNumber.text = @"工单：BMPO2019112043";
    
    self.txtOfStrategy = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfStrategy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfOrderNumber);
        make.top.equalTo(self.txtOfOrderNumber.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.equalTo(self.txtOfTime);
        make.bottom.offset(-10);
    }];
    self.txtOfStrategy.text = @"对策：A88";
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

@end
