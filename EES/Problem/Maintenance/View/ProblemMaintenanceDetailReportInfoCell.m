//
//  ProblemMaintenanceDetailReportInfoCell.m
//  EES
//
//  Created by Albus on 2019-11-20.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemMaintenanceDetailReportInfoCell.h"
#import "MaintenanceDetailModel.h"

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
    
    self.txtOfType = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfType.textAlignment = NSTextAlignmentRight;
    self.txtOfType.adjustsFontSizeToFitWidth = YES;
    [self.txtOfType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfChanxian);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.txtOfChanxian.mas_right).offset(3);
    }];
    
    
    self.txtOfBaoxiu = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfBaoxiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfChanxian);
        make.top.equalTo(self.txtOfChanxian.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    
    self.txtOfBaoxiuren = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfBaoxiuren.textAlignment = NSTextAlignmentRight;
    self.txtOfBaoxiuren.adjustsFontSizeToFitWidth = YES;
    [self.txtOfBaoxiuren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfBaoxiu);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.txtOfBaoxiu.mas_right).offset(3);
    }];
    
    
    self.txtOfXianxiang = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfXianxiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfBaoxiu);
        make.top.equalTo(self.txtOfBaoxiu.mas_bottom).offset(0);
        make.right.offset(-10);
        make.height.mas_greaterThanOrEqualTo(21);
        make.bottom.offset(-10);
    }];
}

- (void)resetSubviewsWithData:(MaintenanceDetailModel *)data {
    self.txtOfChanxian.text = [NSString stringWithFormat:@"产线：%@", AVOIDNULL(data.LineName)];
    
    self.txtOfType.text = [NSString stringWithFormat:@"类型：%@", AVOIDNULL(data.BMTypeName)];
    
    self.txtOfBaoxiu.text = [NSString stringWithFormat:@"报修：%@", AVOIDNULL(data.ReuqestTimeFormat)];
    
    self.txtOfBaoxiuren.text = [NSString stringWithFormat:@"报修人：%@", AVOIDNULL(data.RequestOperatorDesc)];
    
    self.txtOfXianxiang.text = [NSString stringWithFormat:@"现象：%@", AVOIDNULL(data.ItemDesc)];
}

@end
