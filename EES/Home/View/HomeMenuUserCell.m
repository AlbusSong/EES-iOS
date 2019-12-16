//
//  HomeMenuUserCell.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "HomeMenuUserCell.h"

@interface HomeMenuUserCell ()

@property (nonatomic, strong) UIImageView *imgvOfPortrait;

@property (nonatomic, strong) UILabel *txtOfUsername;

@property (nonatomic, strong) UILabel *txtOfNickname;

@end

@implementation HomeMenuUserCell

- (void)initSubviews {
    self.imgvOfPortrait = [[UIImageView alloc] init];
    self.imgvOfPortrait.layer.cornerRadius = 60/2.0;
    self.imgvOfPortrait.contentMode = UIViewContentModeScaleAspectFill;
    self.imgvOfPortrait.backgroundColor = DEFAULT_VIEW_BACKGROUND_COLOR;
    self.imgvOfPortrait.image = [UIImage imageNamed:@"home_menu_user_portrait_icon"];
    self.imgvOfPortrait.clipsToBounds = YES;
    [self.contentView addSubview:self.imgvOfPortrait];
    [self.imgvOfPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.height.mas_equalTo(60);
        make.centerY.equalTo(self.contentView);
    }];
//    [self.imgvOfPortrait customSetImageWithImageURL:@"https://i2.kknews.cc/SIG=22s37a7/566q00061475srn856s9.jpg"];
    
    self.txtOfUsername = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR) parentView:self.contentView];
    [self.txtOfUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgvOfPortrait.mas_right).offset(10);
        make.top.equalTo(self.imgvOfPortrait.mas_top).offset(5);
        make.height.mas_equalTo(21);
    }];
    self.txtOfUsername.text = AVOIDNULL(MeInfo.sharedInstance.username);
    
    self.txtOfNickname = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:HexColor(MAIN_COLOR) parentView:self.contentView];
    [self.txtOfNickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgvOfPortrait.mas_right).offset(10);
        make.bottom.equalTo(self.imgvOfPortrait.mas_bottom).offset(-5);
        make.height.mas_equalTo(21);
    }];
    self.txtOfNickname.text = AVOIDNULL(MeInfo.sharedInstance.password);
}

@end
