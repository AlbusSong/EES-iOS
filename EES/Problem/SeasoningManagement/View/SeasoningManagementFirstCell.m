//
//  SeasoningManagementFirstCell.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "SeasoningManagementFirstCell.h"

@interface SeasoningManagementFirstCell ()

@property (nonatomic, strong) UILabel *txtOfInfo1;

@property (nonatomic, strong) UILabel *txtOfInfo2;

@property (nonatomic, strong) UILabel *txtOfInfo3;

@property (nonatomic, strong) UILabel *txtOfInfo4;

@property (nonatomic, strong) UILabel *txtOfInfo5;

@property (nonatomic, strong) UILabel *txtOfInfo6;

@property (nonatomic, strong) UILabel *txtOfInfo7;

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
    self.txtOfInfo1.text = @"辅料条码：";
    
    self.txtOfInfo2 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo1.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfInfo2.text = @"物料编码：";
    
    self.txtOfInfo3 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo2.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    self.txtOfInfo3.text = @"物料名称：";
    
    self.txtOfInfo4 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo3.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    self.txtOfInfo4.text = @"制造厂商：";
    
    self.txtOfInfo5 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo4.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    self.txtOfInfo5.text = @"使用次数：";
    
    self.txtOfInfo6 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo5.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    self.txtOfInfo6.text = @"适用类型：";
    
    self.txtOfInfo7 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfInfo7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.txtOfInfo6.mas_bottom).offset(15);
        make.right.offset(-10);
        make.height.mas_greaterThanOrEqualTo(21);
        make.bottom.offset(-10);
    }];
    self.txtOfInfo7.text = @"适用机型：";
}

@end
