//
//  LoginTimeoutHintCell.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "LoginTimeoutHintCell.h"

@interface LoginTimeoutHintCell ()

@property (nonatomic, strong) UILabel *txtOfContent;

@end

@implementation LoginTimeoutHintCell

- (void)initSubviews {
    self.txtOfContent = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.bottom.offset(-30);
        make.left.offset(30);
        make.right.offset(-30);
    }];
    
    NSString *content = @"很抱歉的通知您，由于一下原因您已被强制下线：\n\n1、您已登录超时\n\n2、您已被他人强制登录挤下线了\n\n请重新登录";
    NSMutableAttributedString *mAttri = [[NSMutableAttributedString alloc] initWithString:content];
    NSString *redContent1 = @"登录超时";
    NSRange range1 = [content rangeOfString:redContent1];
    if (range1.location != NSNotFound) {
        [mAttri addAttribute:NSForegroundColorAttributeName value:HexColor(@"eb4b40") range:range1];
    }
    NSString *redContent2 = @"被他人强制登录";
    NSRange range2 = [content rangeOfString:redContent2];
    if (range2.location != NSNotFound) {
        [mAttri addAttribute:NSForegroundColorAttributeName value:HexColor(@"eb4b40") range:range2];
    }
    NSString *redContent3 = @"重新登录";
    NSRange range3 = [content rangeOfString:redContent3];
    if (range3.location != NSNotFound) {
        [mAttri addAttribute:NSForegroundColorAttributeName value:HexColor(@"eb4b40") range:range3];
    }
    self.txtOfContent.attributedText = mAttri;
}

@end
