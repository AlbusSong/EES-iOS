//
//  HomeMenuFunctionCell.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "HomeMenuFunctionCell.h"

@interface HomeMenuFunctionCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@end

@implementation HomeMenuFunctionCell

- (void)initSubviews {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:17] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(23);
    }];
}

- (void)resetSubviewsWithTitle:(NSString *)title {
    self.txtOfTitle.text = title;
}

@end
