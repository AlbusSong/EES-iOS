//
//  ProblemGroupCheckDetailItemCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemGroupCheckDetailItemCell.h"

@interface ProblemGroupCheckDetailItemCell ()

@property (nonatomic, strong) UILabel *txtOfProject;

@property (nonatomic, strong) UILabel *txtOfType;

@property (nonatomic, strong) UILabel *txtOfStandard;

@property (nonatomic, strong) UILabel *txtOfMethod;

@property (nonatomic, strong) UILabel *txtOfAttachmentTitle;

@property (nonatomic, strong) UILabel *txtOfAttachment;


@property (nonatomic, strong) UITextField *tfdOfInput;

@property (nonatomic, strong) UISegmentedControl *smcOfDecision;


@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemGroupCheckDetailItemCell

- (void)initSubviews {
    self.txtOfProject = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfProject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfProject.text = @"项目：电极推出压力";
    
    self.txtOfType = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.txtOfProject.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfType.text = @"判断类型：数值判断";
    
    self.txtOfStandard = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfStandard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.txtOfType.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfStandard.text = @"基准：按下按钮设备停止";
    
    self.txtOfMethod = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.txtOfStandard.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfMethod.text = @"方法工具：目测";
    
    self.txtOfAttachmentTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfAttachmentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.txtOfMethod.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfAttachmentTitle.text = @"附    件：";
    
    self.txtOfAttachment = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(MAIN_COLOR) parentView:self.contentView];
    self.txtOfAttachment.userInteractionEnabled = YES;
    [self.txtOfAttachment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(txtOfAttachmentClicked)]];
    [self.txtOfAttachment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfAttachmentTitle.mas_right).offset(10);
        make.top.equalTo(self.txtOfAttachmentTitle);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.txtOfAttachment.text = @"点击查看图片";
    
    
    self.tfdOfInput = [UITextField quickTextFieldWithFont:[UIFont systemFontOfSize:18] textColor:HexColor(MAIN_COLOR_BLACK)];
    self.tfdOfInput.placeholder = @"请输入数值";
    [self.contentView addSubview:self.tfdOfInput];
    [self.tfdOfInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.equalTo(self.txtOfAttachmentTitle.mas_bottom).offset(5);
        make.width.mas_greaterThanOrEqualTo(100);
        make.height.mas_equalTo(30);
        make.bottom.offset(-10);
    }];
    
    self.smcOfDecision = [[UISegmentedControl alloc] initWithItems:@[@"OK", @"NG"]];
    [self.smcOfDecision addTarget:self action:@selector(smcOfDecisionClicked:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.smcOfDecision];
    [self.smcOfDecision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.equalTo(self.txtOfAttachmentTitle.mas_bottom).offset(5);
        make.width.mas_greaterThanOrEqualTo(100);
        make.height.mas_equalTo(30);
        make.bottom.offset(-10);
    }];
    
    int choose = arc4random()%2;
    if (choose == 0) {
        self.tfdOfInput.hidden = YES;
        self.smcOfDecision.hidden = NO;
    } else {
        self.tfdOfInput.hidden = NO;
        self.smcOfDecision.hidden = YES;
    }
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark gestures

- (void)smcOfDecisionClicked:(UISegmentedControl *)sender {
    NSLog(@"smcOfDecisionClicked: %li", sender.selectedSegmentIndex);
}

- (void)txtOfAttachmentClicked {
    NSLog(@"txtOfAttachmentClicked");
}

@end
