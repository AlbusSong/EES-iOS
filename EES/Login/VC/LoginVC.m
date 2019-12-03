//
//  LoginVC.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "LoginVC.h"
#import "LoginInputView.h"

@interface LoginVC () <LoginInputViewDelegate>

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *password;


@property (nonatomic, strong) UIView *wrapperView;


@property (nonatomic, strong) LoginInputView *inputViewOfUsername;

@property (nonatomic, strong) LoginInputView *inputViewOfPassword;

@property (nonatomic, strong) UIButton *btnToRememberMe;

@property (nonatomic, strong) UIButton *btnLogin;

@end

@implementation LoginVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];
}

- (void)initSubviews {
    UIImageView *imgvOfBackground = [[UIImageView alloc] init];
    imgvOfBackground.contentMode = UIViewContentModeScaleAspectFill;
    imgvOfBackground.backgroundColor = RANDOM_COLOR;
    imgvOfBackground.clipsToBounds = YES;
    imgvOfBackground.image = [UIImage imageNamed:@"Login-Background"];
    [self.view addSubview:imgvOfBackground];
    [imgvOfBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
//    [imgvOfBackground customSetImageWithImageURL:@"http://bizhi.bcoderss.com/wp-content/uploads/2018/10/全面屏壁纸_35.jpg"];
    
    self.wrapperView = [[UIView alloc] init];
    self.wrapperView.backgroundColor = UIColor.whiteColor;
    self.wrapperView.clipsToBounds = YES;
    self.wrapperView.layer.cornerRadius = 4;
    self.wrapperView.layer.borderWidth = 1;
    self.wrapperView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:self.wrapperView];
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(35);
        make.right.offset(-35);
        make.height.mas_equalTo(300);
        make.centerY.equalTo(self.view);
    }];
    
    UILabel *txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:30] textColor:HexColor(@"ffffff") parentView:self.wrapperView];
    txtOfTitle.textAlignment = NSTextAlignmentCenter;
    txtOfTitle.backgroundColor = HexColor(MAIN_COLOR);
    [txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.wrapperView);
        make.height.mas_equalTo(80);
    }];
    txtOfTitle.text = @"智无形云平台";
    
    self.inputViewOfUsername = [[LoginInputView alloc] init];
    [self.inputViewOfUsername setPlaceholder:@"用户名"];
    self.inputViewOfUsername.delegate = self;
    [self.wrapperView addSubview:self.inputViewOfUsername];
    [self.inputViewOfUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.offset(-25);
        make.top.equalTo(txtOfTitle.mas_bottom).offset(25);
        make.height.mas_equalTo(40);
    }];
    
    self.inputViewOfPassword = [[LoginInputView alloc] init];
    [self.inputViewOfPassword setPlaceholder:@"密码"];
    self.inputViewOfPassword.delegate = self;
    [self.wrapperView addSubview:self.inputViewOfPassword];
    [self.inputViewOfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.offset(-25);
        make.top.equalTo(self.inputViewOfUsername.mas_bottom).offset(25);
        make.height.mas_equalTo(40);
    }];
    
    self.btnToRememberMe = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnToRememberMe.tintColor = HexColor(MAIN_COLOR_BLACK);
    self.btnToRememberMe.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btnToRememberMe setTitle:@"记住账户" forState:UIControlStateNormal];
    [self.btnToRememberMe setImage:[UIImage imageNamed:@"Login-RememberMe-Check"] forState:UIControlStateNormal];
    [self.btnToRememberMe setImagePosition:ButtonImagePositionLeft spacing:5];
    [self.wrapperView addSubview:self.btnToRememberMe];
    [self.btnToRememberMe mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.offset(25);
       make.top.equalTo(self.inputViewOfPassword.mas_bottom).offset(10);
       make.height.mas_equalTo(25);
    }];
    
    self.btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnLogin.clipsToBounds = YES;
    self.btnLogin.layer.cornerRadius = 4;
    self.btnLogin.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnLogin setTitle:@"登陆" forState:UIControlStateNormal];
    [self.btnLogin setBackgroundImage:[GlobalTool imageWithColor:HexColor(@"e68073")] forState:UIControlStateNormal];
    [self.wrapperView addSubview:self.btnLogin];
    [self.btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.offset(-25);
        make.top.equalTo(self.btnToRememberMe.mas_bottom).offset(10);
        make.height.mas_equalTo(55);
    }];
    
    [self.wrapperView layoutIfNeeded];
    NSLog(@"self.btnLogin.bottom: %f", self.btnLogin.bottom);
    [self.wrapperView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.btnLogin.bottom + 80);
    }];
}

#pragma mark LoginInputViewDelegate

- (void)inputView:(LoginInputView *)inputView contentHasChangedTo:(NSString *)newContent {
    if (inputView == self.inputViewOfUsername) {
        self.username = newContent;
    } else {
        self.password = newContent;
    }
}

@end
