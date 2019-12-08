//
//  ProblemWholeCheckSubmitTitleCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckSubmitTitleCell.h"

@interface ProblemWholeCheckSubmitTitleCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@end

@implementation ProblemWholeCheckSubmitTitleCell

- (void)initSubviews {
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:18] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(25);
        make.left.offset(10);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    self.txtOfTitle.text = @"项目：电机";
}

- (void)resetSubviewsWithTitle:(NSString *)title {
    self.txtOfTitle.text = title;
}

@end
