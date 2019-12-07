//
//  ProblemWholeCheckDetailItemCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckDetailItemCell.h"
#import "WholeCheckDetailItemModel.h"

@interface ProblemWholeCheckDetailItemCell ()

@property (nonatomic, strong) UILabel *txtOfProject;

@property (nonatomic, strong) UILabel *txtOfEquipment;

@property (nonatomic, strong) UILabel *txtOfMethod;

@property (nonatomic, strong) UILabel *txtOfResult;


@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemWholeCheckDetailItemCell

- (void)initSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.txtOfProject = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfProject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.right.offset(-10);
        make.left.offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    
    self.txtOfEquipment = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfEquipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfProject.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    
    self.txtOfMethod = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfEquipment.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    
    self.txtOfResult = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfMethod.mas_bottom).offset(0);
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

- (void)resetSubviewsWithData:(WholeCheckDetailItemModel *)data {
    self.txtOfProject.text = [NSString stringWithFormat:@"点检项目：%@", data.Project];
    
    self.txtOfEquipment.text = [NSString stringWithFormat:@"部件：%@", [NSString avoidNull:data.Part]];
    
    self.txtOfMethod.text = [NSString stringWithFormat:@"方法：%@", [NSString avoidNull:data.Method]];
    
    self.txtOfResult.text = [NSString stringWithFormat:@"结果：%@", AVOIDNULL(data.AppResult)];
}

@end
