//
//  ProblemWholeCheckSubmitInfoCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckSubmitInfoCell.h"
#import "WholeCheckDetailItemDetailModel.h"

@interface ProblemWholeCheckSubmitInfoCell ()

@property (nonatomic, strong) WholeCheckDetailItemDetailModel *data;


@property (nonatomic, strong) UIView *grayLine;


@property (nonatomic, strong) UILabel *txtOfInstitute;

@property (nonatomic, strong) UILabel *txtOfEquipment;

@property (nonatomic, strong) UILabel *txtOfStandard;

//@property (nonatomic, strong) UILabel *txtOfMethod;

@property (nonatomic, strong) UILabel *txtOfTool;

@property (nonatomic, strong) UILabel *txtOfAttachment;

@property (nonatomic, strong) UILabel *txtOfPhenomenon;

@property (nonatomic, strong) UILabel *txtOfStrategy;

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
    
    
    self.txtOfEquipment = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfEquipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfInstitute.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    
    self.txtOfStandard = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfStandard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfEquipment.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    
//    self.txtOfMethod = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
//    [self.txtOfMethod mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(10);
//        make.right.offset(-10);
//        make.top.equalTo(self.txtOfStandard.mas_bottom).offset(10);
//        make.height.mas_greaterThanOrEqualTo(21);
//    }];
    
    
    self.txtOfTool = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfStandard.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    self.txtOfAttachment = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfAttachment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfTool.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    self.txtOfPhenomenon = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfPhenomenon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfAttachment.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    self.txtOfStrategy = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfStrategy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.txtOfPhenomenon.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
}

- (void)resetSubviewsWithData:(WholeCheckDetailItemDetailModel *)data {
    self.data = data;
    
    self.txtOfInstitute.text = [NSString stringWithFormat:@"机构：%@", AVOIDNULL(data.Mechanism)];
    
    self.txtOfEquipment.text = [NSString stringWithFormat:@"部件：%@", AVOIDNULL(data.Part)];
    
    self.txtOfStandard.text = [NSString stringWithFormat:@"标准：%@\n%@", AVOIDNULL(data.Standard), AVOIDNULL(data.Method)];
    
    self.txtOfTool.text = [NSString stringWithFormat:@"工具：%@", AVOIDNULL(data.ToolName.trim)];
    
    self.txtOfAttachment.text = [NSString stringWithFormat:@"附件：%@", @"未上传附件"];
    
    self.txtOfPhenomenon.text = [NSString stringWithFormat:@"现象：%@", AVOIDNULL(data.Phenomenon)];
    
    self.txtOfStrategy.text = [NSString stringWithFormat:@"策略：%@", AVOIDNULL(data.Countermeasure)];
}

- (void)resetAttachmentInfo:(NSString *)attachmentInfo {
    self.txtOfAttachment.text = [NSString stringWithFormat:@"附件：%@", AVOIDNULL(attachmentInfo)];
    
    if ([attachmentInfo isEqualToString:@"未上传附件"]) {
        self.txtOfAttachment.textColor = HexColor(@"999999");
        self.txtOfAttachment.userInteractionEnabled = NO;
    } else {
        self.txtOfAttachment.textColor = HexColor(MAIN_COLOR);
        self.txtOfAttachment.userInteractionEnabled = YES;
    }
}

- (void)showPhenomenonAndStrategy:(BOOL)shouldShow {
    if (shouldShow) {
        self.txtOfPhenomenon.hidden = NO;
        self.txtOfStrategy.hidden = NO;
        [self.txtOfAttachment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.top.equalTo(self.txtOfTool.mas_bottom).offset(10);
            make.height.mas_greaterThanOrEqualTo(21);
        }];
        
        [self.txtOfStrategy mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.top.equalTo(self.txtOfPhenomenon.mas_bottom).offset(10);
            make.height.mas_greaterThanOrEqualTo(21);
            make.bottom.offset(-10);
        }];
    } else {
        self.txtOfPhenomenon.hidden = YES;
        self.txtOfStrategy.hidden = YES;
        [self.txtOfAttachment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.top.equalTo(self.txtOfTool.mas_bottom).offset(10);
            make.height.mas_greaterThanOrEqualTo(21);
            make.bottom.offset(-10);
        }];
        
//        [self.txtOfStrategy mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(10);
//            make.right.offset(-10);
//            make.top.equalTo(self.txtOfPhenomenon.mas_bottom).offset(10);
//            make.height.mas_greaterThanOrEqualTo(21);
//        }];
    }
}

@end
