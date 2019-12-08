//
//  ProblemWholeCheckSubmitAttachmentCell.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckSubmitAttachmentCell.h"

@interface ProblemWholeCheckSubmitAttachmentCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UIButton *btnUploadAttachment;

@end

@implementation ProblemWholeCheckSubmitAttachmentCell

- (void)initSubviews {
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(21);
        make.left.offset(10);
        make.top.offset(5);
        make.bottom.offset(-10);
    }];
    self.txtOfTitle.text = @"附件: ";
    
    self.btnUploadAttachment = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnUploadAttachment.clipsToBounds = YES;
    self.btnUploadAttachment.layer.cornerRadius = 4;
    self.btnUploadAttachment.layer.borderWidth = 1;
    self.btnUploadAttachment.layer.borderColor = HexColor(MAIN_COLOR_BLACK).CGColor;
    self.btnUploadAttachment.tintColor = HexColor(MAIN_COLOR_BLACK);
    [self.btnUploadAttachment setTitle:@"Choose" forState:UIControlStateNormal];
    [self.btnUploadAttachment addTarget:self action:@selector(btnUploadAttachmentClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnUploadAttachment];
    [self.btnUploadAttachment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle.mas_right).offset(10);
        make.height.mas_equalTo(25);
        make.centerY.equalTo(self.txtOfTitle);
        make.width.mas_equalTo(80);
    }];
}

#pragma mark gestures

- (void)btnUploadAttachmentClicked {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tryToChooseFile)]) {
        [self.delegate tryToChooseFile];
    }
}

@end
