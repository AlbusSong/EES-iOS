//
//  MaintenanceEditInputSelectionCell.m
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "MaintenanceEditInputSelectionCell.h"

@interface MaintenanceEditInputSelectionCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *txtOfContent;

@property (nonatomic, strong) UIImageView *imgvOfSmallTriangle;

@end

@implementation MaintenanceEditInputSelectionCell

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

- (void)resetTitle:(NSString *)title {
    self.txtOfTitle.text = title;
}

- (void)setContent:(NSString *)content {
    self.txtOfContent.text = content;
}

@end
