//
//  GroupCheckDetailEditUncheckedTitleCell.m
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "GroupCheckDetailEditUncheckedTitleCell.h"

@interface GroupCheckDetailEditUncheckedTitleCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@end

@implementation GroupCheckDetailEditUncheckedTitleCell

- (void)initSubviews {
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:18] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(25);
        make.left.offset(10);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
}

- (void)resetSubviewsWithTitle:(NSString *)title {
    self.txtOfTitle.text = title;
}

@end
