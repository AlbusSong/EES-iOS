//
//  LoginInputView.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "LoginInputView.h"

@interface LoginInputView ()

@property (nonatomic, strong) UIImageView *imgvOfIcon;

@property (nonatomic, strong) UITextField *tfdOfInput;

@end

@implementation LoginInputView

- (void)initSubviews {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4;
    self.layer.borderColor = HexColor(MAIN_COLOR).CGColor;
    self.layer.borderWidth = 1;
    
    self.imgvOfIcon = [[UIImageView alloc] init];
    self.imgvOfIcon.contentMode = UIViewContentModeCenter;
    self.imgvOfIcon.clipsToBounds = YES;
    self.imgvOfIcon.backgroundColor = HexColor(MAIN_COLOR);
    [self addSubview:self.imgvOfIcon];
    [self.imgvOfIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    
    self.tfdOfInput = [UITextField quickTextFieldWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(MAIN_COLOR_BLACK)];
    [self.tfdOfInput addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.tfdOfInput];
    [self.tfdOfInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgvOfIcon.mas_right).offset(5);
        make.top.bottom.equalTo(self);
        make.right.offset(-3);
    }];
    self.tfdOfInput.placeholder = @"1234";
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.tfdOfInput.placeholder = placeholder;
}

- (void)setContent:(NSString *)content {
    self.tfdOfInput.text = content;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    self.tfdOfInput.keyboardType = keyboardType;
}

- (void)setIsSecureTextEntry:(BOOL)isSecureTextEntry {
    self.tfdOfInput.secureTextEntry = isSecureTextEntry;
}

- (void)setIconImage:(UIImage *)image {
    self.imgvOfIcon.image = image;
}

#pragma mark changed delegate

- (void)textChanged:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputView:contentHasChangedTo:)]) {
        [self.delegate inputView:self contentHasChangedTo:textField.text];
    }
}

@end
