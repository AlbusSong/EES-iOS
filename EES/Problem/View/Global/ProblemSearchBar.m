//
//  ProblemSearchBar.m
//  EES
//
//  Created by Albus on 20/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemSearchBar.h"

@interface ProblemSearchBar () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *viewOfInputBackground;

@property (nonatomic, strong) UIImageView *imgvOfSearch;

@property (nonatomic, strong) UITextField *tfdOfContent;

@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemSearchBar

- (void)initSubviews {
    self.viewOfInputBackground = [[UIView alloc] init];
    self.viewOfInputBackground.backgroundColor = HexColor(@"f1f1f1");
    self.viewOfInputBackground.layer.cornerRadius = 6;
    self.viewOfInputBackground.clipsToBounds = YES;
    [self addSubview:self.viewOfInputBackground];
    [self.viewOfInputBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.mas_equalTo(32);
        make.left.offset(18);
        make.right.offset(-18);
    }];
    
    self.imgvOfSearch = [[UIImageView alloc] init];
//    self.imgvOfSearch.backgroundColor = RANDOM_COLOR;
    self.imgvOfSearch.image = [UIImage imageNamed:@"search_bar_icon"];
    [self.viewOfInputBackground addSubview:self.imgvOfSearch];
    [self.imgvOfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(7);
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self.viewOfInputBackground);
    }];
    
    
    self.tfdOfContent = [UITextField quickTextFieldWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK) placeholderColor:HexColor(@"bebebe")];
    self.tfdOfContent.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tfdOfContent.returnKeyType = UIReturnKeySearch;
    [self.tfdOfContent addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    self.tfdOfContent.delegate = self;
    [self.viewOfInputBackground addSubview:self.tfdOfContent];
    [self.tfdOfContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgvOfSearch.mas_right).offset(5);
        make.right.offset(-5);
        make.top.bottom.equalTo(self.viewOfInputBackground);
    }];
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = DEFAULT_VIEW_BACKGROUND_COLOR;
    [self addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark actions

- (void)setSearchHint:(NSString *)hintString {
    self.tfdOfContent.placeholder = hintString;
}

#pragma mark changed delegate

- (void)textChanged:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchContentChangedTo:)]) {
        [self.delegate searchContentChangedTo:textField.text];
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tryToSearch)]) {
        [self.delegate tryToSearch];
    }
    return YES;
}

@end

