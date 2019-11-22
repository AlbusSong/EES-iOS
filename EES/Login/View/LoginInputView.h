//
//  LoginInputView.h
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASView.h"

NS_ASSUME_NONNULL_BEGIN

@class LoginInputView;

@protocol LoginInputViewDelegate <NSObject>

@optional
- (void)inputView:(LoginInputView *)inputView contentHasChangedTo:(NSString *)newContent;

@end

@interface LoginInputView : ASView

@property (nonatomic, weak) id <LoginInputViewDelegate> delegate;


- (void)setPlaceholder:(NSString *)placeholder;

- (void)setIconImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
