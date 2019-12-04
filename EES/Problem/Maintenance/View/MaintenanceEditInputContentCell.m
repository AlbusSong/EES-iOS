//
//  MaintenanceEditInputContentCell.m
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "MaintenanceEditInputContentCell.h"

@interface MaintenanceEditInputContentCell () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextView *txvOfContent;

@property (nonatomic, strong) UILabel *txtOfPlaceholder;

@end

@implementation MaintenanceEditInputContentCell

- (void)initSubviews {
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(@"333333") parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(21);
    }];
    
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.clipsToBounds = YES;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.borderColor = HexColor(@"999999").CGColor;
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle.mas_right).offset(10);
        make.right.offset(-15);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    
    self.txtOfPlaceholder = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:17] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfPlaceholder.backgroundColor = [UIColor whiteColor];
    [self.txtOfPlaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.height.mas_equalTo(23);
        make.top.equalTo(self.bgView.mas_top).offset(8);
    }];
    self.txtOfPlaceholder.text = @"产线";
    
    self.txvOfContent = [[UITextView alloc] init];
    self.txvOfContent.textColor = HexColor(MAIN_COLOR_BLACK);
    self.txvOfContent.font = [UIFont systemFontOfSize:17];
    self.txvOfContent.delegate = self;
    [self.bgView addSubview:self.txvOfContent];
    [self.txvOfContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(5);
        make.right.equalTo(self.bgView.mas_right).offset(-5);
        make.top.equalTo(self.bgView).offset(2);
        make.bottom.equalTo(self.bgView).offset(-2);
    }];
}

- (void)resetPlaceholder:(NSString *)placeholder {
    self.txtOfPlaceholder.text = placeholder;
}

- (void)resetTitle:(NSString *)title {
    self.txtOfTitle.text = title;
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.txtOfPlaceholder.hidden = (textView.text.length > 0);
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentHasChangedTo:)]) {
        [self.delegate contentHasChangedTo:textView.text];
    }
}

@end
