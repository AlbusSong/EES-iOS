//
//  ProblemNewReportSelectionCell.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemNewReportSelectionCell.h"

@interface ProblemNewReportSelectionCell ()

@end

@implementation ProblemNewReportSelectionCell

- (void)initSubviews {
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.clipsToBounds = YES;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.borderColor = HexColor(@"999999").CGColor;
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:17] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfTitle.backgroundColor = [UIColor whiteColor];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.height.mas_equalTo(23);
        make.centerY.equalTo(self.bgView);
    }];
    self.txtOfTitle.text = @"产线";
    
    self.txtOfContent = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:17] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.height.mas_equalTo(23);
        make.centerY.equalTo(self.bgView);
        make.right.equalTo(self.bgView.mas_right).offset(-15);
    }];
    
    
    self.imgvOfSmallTriangle = [[UIImageView alloc] init];
    self.imgvOfSmallTriangle.contentMode = UIViewContentModeScaleAspectFill;
    self.imgvOfSmallTriangle.image = [UIImage imageNamed:@"故障报修-下三角"];
    [self.contentView addSubview:self.imgvOfSmallTriangle];
    [self.imgvOfSmallTriangle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-8);
        make.centerY.equalTo(self.bgView);
        make.width.height.mas_equalTo(10);
    }];
}

#pragma mark actions

- (void)resetTitle:(NSString *)title {
    self.txtOfTitle.text = title;
}

- (void)setContent:(NSString *)content {
    self.txtOfContent.text = content;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.txtOfTitle.text = placeholder;
}

- (void)showHilighted:(BOOL)shouldHighlight {
    if (shouldHighlight == YES) {
        [UIView transitionWithView:self.contentView duration:0.30 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.txtOfTitle.font = [UIFont systemFontOfSize:10];
            self.txtOfTitle.textColor = HexColor(MAIN_COLOR_BLACK);
            [self.txtOfTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgView.mas_left).offset(15);
                make.height.mas_equalTo(13);
                make.centerY.equalTo(self.bgView.mas_top);
            }];
            [self.contentView layoutIfNeeded];
            
            self.bgView.layer.borderColor = HexColor(MAIN_COLOR).CGColor;
        } completion:nil];
    } else {
        [UIView transitionWithView:self.contentView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            if (self.txtOfContent.text.length == 0) {
                self.txtOfTitle.font = [UIFont systemFontOfSize:17];
                self.txtOfTitle.textColor = HexColor(@"999999");
                [self.txtOfTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.bgView.mas_left).offset(15);
                    make.height.mas_equalTo(23);
                    make.centerY.equalTo(self.bgView);
                }];
                [self.contentView layoutIfNeeded];
            }
            
            self.bgView.layer.borderColor = HexColor(@"999999").CGColor;
        } completion:nil];
    }
}

@end
