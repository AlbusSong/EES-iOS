//
//  SeasoningManagementSecondCell.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "SeasoningManagementSecondCell.h"

@interface SeasoningManagementSecondCell ()

@property (nonatomic, strong) UIView *grayLine;

@property (nonatomic, strong) UILabel *txtOfInfo1;

@property (nonatomic, strong) UILabel *txtOfInfo2;

@property (nonatomic, strong) UILabel *txtOfInfo3;

@end

@implementation SeasoningManagementSecondCell

- (void)initSubviews {
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
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
        make.bottom.offset(-10);
    }];
    self.txtOfInfo3.text = @"物料名称：";
}

@end
