//
//  ProblemWholeCheckDetailItemCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckDetailItemCell.h"

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
    self.txtOfProject.text = @"点检项目：气缸";
    
    self.txtOfEquipment = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfEquipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfProject.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfEquipment.text = @"部件：";
    
    self.txtOfMethod = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfEquipment.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfMethod.text = @"方法：1.在气缸工作时，目测到位或复位传感器工作指示灯有无变化（例如红灯亮起）2.在气缸工作时，目测气缸杆有无位移变化";
    
    self.txtOfResult = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfMethod.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
        make.bottom.offset(-10);
    }];
    self.txtOfResult.text = @"结果：无";
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

@end
