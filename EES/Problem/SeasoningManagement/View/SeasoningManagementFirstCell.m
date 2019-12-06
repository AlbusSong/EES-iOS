//
//  SeasoningManagementFirstCell.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "SeasoningManagementFirstCell.h"
#import "SeasoningManagementDetailModel.h"

@interface SeasoningManagementFirstCell ()

@property (nonatomic, strong) UILabel *txtOfInfo1;

@property (nonatomic, strong) UILabel *txtOfInfo2;

@property (nonatomic, strong) UILabel *txtOfInfo3;

@property (nonatomic, strong) UILabel *txtOfInfo4;

@property (nonatomic, strong) UILabel *txtOfInfo5;

@property (nonatomic, strong) UILabel *txtOfInfo6;

@property (nonatomic, strong) UILabel *txtOfInfo7;

@property (nonatomic, strong) UIView *grayLine;

@end

@implementation SeasoningManagementFirstCell

- (void)initSubviews {
    self.txtOfInfo1 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    self.txtOfInfo2 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo1.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    
    self.txtOfInfo3 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo2.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    self.txtOfInfo4 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo3.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    self.txtOfInfo5 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo4.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    
    self.txtOfInfo6 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo5.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    
    self.txtOfInfo7 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo6.mas_bottom).offset(15);
        make.right.offset(-10);
        make.height.mas_greaterThanOrEqualTo(21);
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

- (void)resetSubviewsWithData:(SeasoningManagementDetailModel *)data {
    self.txtOfInfo1.text = [NSString stringWithFormat:@"辅料条码：%@", [NSString avoidNull:data.ASCode]];
    
    self.txtOfInfo2.text = [NSString stringWithFormat:@"物料编码：%@", [NSString avoidNull:data.Item]];
    
    self.txtOfInfo3.text = [NSString stringWithFormat:@"物料名称：%@", [NSString avoidNull:data.Name]];
    
    self.txtOfInfo4.text = [NSString stringWithFormat:@"制造厂商：%@", [NSString avoidNull:data.Manufacturer]];
    
    self.txtOfInfo5.text = [NSString stringWithFormat:@"使用次数：%@", [NSString avoidNull:data.ActUseCount]];
    
    self.txtOfInfo6.text = [NSString stringWithFormat:@"适用类型：%@", [NSString avoidNull:data.UsePartType]];
    
    self.txtOfInfo7.text = [NSString stringWithFormat:@"适用机型：%@", [NSString avoidNull:data.UsePart]];
}

@end
