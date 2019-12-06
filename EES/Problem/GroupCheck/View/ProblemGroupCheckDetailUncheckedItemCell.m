//
//  ProblemGroupCheckDetailUncheckedItemCell.m
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemGroupCheckDetailUncheckedItemCell.h"
#import "GroupCheckDetailItemModel.h"

@interface ProblemGroupCheckDetailUncheckedItemCell ()

@property (nonatomic, strong) UIView *grayLine;

@property (nonatomic, strong) UILabel *txtOfInfo1;

@property (nonatomic, strong) UILabel *txtOfInfo2;

@property (nonatomic, strong) UILabel *txtOfInfo3;

@property (nonatomic, strong) UILabel *txtOfInfo4;

@property (nonatomic, strong) UILabel *txtOfInfo5;

@end

@implementation ProblemGroupCheckDetailUncheckedItemCell

- (void)initSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
        make.right.offset(-10);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
    
    self.txtOfInfo2 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfInfo1.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(21);
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
        make.bottom.offset(-10);
    }];
    
    self.txtOfInfo5 = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfInfo5.textAlignment = NSTextAlignmentRight;
    [self.txtOfInfo5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfInfo4.mas_right).offset(5);
        make.top.equalTo(self.txtOfInfo4);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.offset(-10);
    }];
}

- (void)resetSubviewsWithData:(GroupCheckDetailItemModel *)data {
    self.txtOfInfo1.text = [NSString stringWithFormat:@"点检项目：%@", data.Project];
    
    self.txtOfInfo2.text = [NSString stringWithFormat:@"判断类型：%@", data.JudgeType];
    
    self.txtOfInfo3.text = [NSString stringWithFormat:@"方法工具：%@", data.MethodTool];
    
    self.txtOfInfo4.text = [NSString stringWithFormat:@"结果：%@", data.AppResult.length > 0 ? data.AppResult : @"NG"];
    
    self.txtOfInfo5.text = [NSString stringWithFormat:@"处理进度：%@", data.AppResult];
}

- (void)shouldShowProgressInfo:(BOOL)shouldShow {
    self.txtOfInfo5.hidden = (!shouldShow);
}

@end
