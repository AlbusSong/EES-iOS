//
//  HomeFunctionModuleCell.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "HomeFunctionModuleCell.h"

@interface HomeFunctionModuleCell ()

@property (nonatomic, strong) UIView *wrapperView;

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UILabel *txtOfBadge;

@property (nonatomic, strong) UIImageView *imgvOfIcon;

@end

@implementation HomeFunctionModuleCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.wrapperView = [[UIView alloc] init];
    self.wrapperView.backgroundColor = HexColor(MAIN_COLOR);
    self.wrapperView.clipsToBounds = YES;
    self.wrapperView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.wrapperView];
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor] parentView:self.wrapperView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.centerX.equalTo(self.wrapperView);
        make.height.mas_equalTo(21);
    }];
    self.txtOfTitle.text = @"故障报修";
    
    NSString *badgeValue = [NSString stringWithFormat:@"%d", arc4random()%15];
    self.txtOfBadge = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:9] textColor:[UIColor whiteColor] parentView:self.wrapperView];
    self.txtOfBadge.backgroundColor = HexColor(@"eb4d3d");
    self.txtOfBadge.clipsToBounds = YES;
    self.txtOfBadge.textAlignment = NSTextAlignmentCenter;
    self.txtOfBadge.layer.cornerRadius = 15/2.0;
    [self.contentView addSubview:self.txtOfBadge];
    [self.txtOfBadge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle.mas_right).offset(4);
        make.top.offset(3);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(MAX(15, [GlobalTool sizeFitsWithSize:CGSizeMake(MAXFLOAT, 15) text:badgeValue font:[UIFont systemFontOfSize:9]].width + 6));
    }];
    self.txtOfBadge.text = badgeValue;
    
    self.imgvOfIcon = [[UIImageView alloc] init];
    self.imgvOfIcon.clipsToBounds = YES;
    self.imgvOfIcon.contentMode = UIViewContentModeScaleAspectFit;
    self.imgvOfIcon.backgroundColor = RANDOM_COLOR;
    [self.contentView addSubview:self.imgvOfIcon];
    [self.imgvOfIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.wrapperView);
        make.top.equalTo(self.txtOfTitle.mas_bottom).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(45);
    }];
}

@end
