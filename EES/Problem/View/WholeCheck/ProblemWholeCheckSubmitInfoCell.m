//
//  ProblemWholeCheckSubmitInfoCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckSubmitInfoCell.h"

@interface ProblemWholeCheckSubmitInfoCell ()

@property (nonatomic, strong) UIView *grayLine;


@property (nonatomic, strong) UILabel *txtOfInstitute;

@property (nonatomic, strong) UILabel *txtOfEquipment;

@property (nonatomic, strong) UILabel *txtOfStandard;

@property (nonatomic, strong) UILabel *txtOfMethod;

@property (nonatomic, strong) UILabel *txtOfTool;

@property (nonatomic, strong) UILabel *txtOfAttachment;

@end

@implementation ProblemWholeCheckSubmitInfoCell

- (void)initSubviews {
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    self.txtOfInstitute = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfInstitute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.right.offset(-10);
        make.left.offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfInstitute.text = @"点检项目：气缸";
    
    self.txtOfEquipment = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfEquipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfInstitute.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfEquipment.text = @"部件：";
    
    self.txtOfStandard = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfStandard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfEquipment.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfStandard.text = @"标准： 1.电机有转动；2.电机无异音；3.电机无震动；4.电机转动连贯；";
    
    self.txtOfMethod = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfStandard.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfMethod.text = @"方法：1.在电机工作时，目测从动部分有无明显位移2.在电机工作时，耳听电机有无发出不规律噪音3.在电机工作时，手触摸电机安装支架部分感触有无明显振动，在电机不工作时，用六角扳手测量紧固情况4.在电机工作时，目测电机从动部分或电机轴有无卡顿现象或明显加减速现象";
    
    self.txtOfTool = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfMethod.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfTool.text = @"工具：/";
    
    self.txtOfAttachment = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfAttachment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfTool.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
        make.bottom.offset(-10);
    }];
    self.txtOfAttachment.text = @"附件：未上传附件";
}

@end
