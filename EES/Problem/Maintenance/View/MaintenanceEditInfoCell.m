//
//  MaintenanceEditInfoCell.m
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "MaintenanceEditInfoCell.h"

@interface MaintenanceEditInfoCell ()

@property (nonatomic, strong) UIView *grayLine;

@end

@implementation MaintenanceEditInfoCell

- (void)resetSubviewsWithInfoArray:(NSArray *)infoArray {
    if (infoArray.count == 0) {
        return;
    }
    
    [self.contentView removeAllSubviews];
    
    UILabel *topLabel;
    for (int i = 0; i < infoArray.count; i++) {
        UILabel *txtOfInfo = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
        txtOfInfo.text = infoArray[i];
        [txtOfInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            if (topLabel) {
                make.top.equalTo(topLabel.mas_bottom).offset(10);
            } else {
                make.top.equalTo(self.contentView).offset(10);
            }
            make.height.mas_greaterThanOrEqualTo(21);
            if (i == (infoArray.count - 1)) {
                make.bottom.offset(-10);
            }
        }];
        topLabel = txtOfInfo;
    }
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

@end
