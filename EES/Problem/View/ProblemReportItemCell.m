//
//  ProblemReportItemCell.m
//  EES
//
//  Created by Albus on 20/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemReportItemCell.h"

@interface ProblemReportItemCell ()

@property (nonatomic, strong) UIImageView *imgvOfSelection;

@property (nonatomic, strong) UILabel *txtOfTime;

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemReportItemCell

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
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

@end
