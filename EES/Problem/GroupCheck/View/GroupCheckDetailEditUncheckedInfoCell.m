//
//  GroupCheckDetailEditUncheckedInfoCell.m
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "GroupCheckDetailEditUncheckedInfoCell.h"
#import "GroupCheckDetailItemModel.h"

@interface GroupCheckDetailEditUncheckedInfoCell ()

@property (nonatomic, strong) UIView *grayLine;

@property (nonatomic, strong) UILabel *txtOfInfo1;

@property (nonatomic, strong) UILabel *txtOfInfo2;

@property (nonatomic, strong) UILabel *txtOfInfo3;

@property (nonatomic, strong) UILabel *txtOfInfo4;

@end

@implementation GroupCheckDetailEditUncheckedInfoCell

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
}

- (void)resetSubviewsWithData:(GroupCheckDetailItemModel *)data {
    self.txtOfInfo1.text = [NSString stringWithFormat:@"判断类别：%@", data.JudgeType];
    
    self.txtOfInfo2.text = [NSString stringWithFormat:@"单位：%@", data.Unit];
    
    self.txtOfInfo3.text = [NSString stringWithFormat:@"结果：%@", data.AppResult.length > 0 ? data.AppResult : @"NG"];
    
    self.txtOfInfo4.text = [NSString stringWithFormat:@"备注：%@", data.Comment];
}

@end
