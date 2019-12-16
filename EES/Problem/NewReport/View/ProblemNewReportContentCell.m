//
//  ProblemNewReportContentCell.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemNewReportContentCell.h"

@interface ProblemNewReportContentCell () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *txvOfContent;

@end

@implementation ProblemNewReportContentCell

- (void)initSubviews {
    [super initSubviews];
    
    self.imgvOfSmallTriangle.hidden = YES;
    [self.txtOfTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.height.mas_equalTo(23);
        make.top.equalTo(self.bgView.mas_top).offset(8);
    }];        
    
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

- (void)showHilighted:(BOOL)shouldHighlight {
    if (shouldHighlight == YES) {
        [super showHilighted:shouldHighlight];
    } else {
        [UIView transitionWithView:self.contentView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            if (self.txvOfContent.text.length == 0) {
                self.txtOfTitle.font = [UIFont systemFontOfSize:17];
                self.txtOfTitle.textColor = HexColor(@"999999");
                [self.txtOfTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.bgView.mas_left).offset(15);
                    make.height.mas_equalTo(23);
                    make.top.equalTo(self.bgView.mas_top).offset(8);
                }];
                [self.contentView layoutIfNeeded];
            }
            
            self.bgView.layer.borderColor = HexColor(@"999999").CGColor;
        } completion:nil];
    }
}

- (void)setEnable:(BOOL)shouldEnable {
    self.txvOfContent.editable = shouldEnable;
}

#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self showHilighted:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self showHilighted:NO];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentHasChangedTo:)]) {
        [self.delegate contentHasChangedTo:textView.text];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentHasChangedTo:atIndexPath:)]) {
        [self.delegate contentHasChangedTo:textView.text atIndexPath:self.indexPath];
    }
}

@end
