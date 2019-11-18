//
//  BaseVC.m
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@property (nonatomic, strong) UIView *navigationBottomLineView;

@end

@implementation BaseVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.backBarButtonItem = nil;
        UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        self.navigationItem.leftBarButtonItem = backBtnItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.hidesBottomBarWhenPushed = YES;
    
//    [self initNavigationThings];
}

#pragma mark init navigation things

- (void)initNavigationThings {
    self.navigationView = [[UIView alloc] init];
    self.navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAVIGATIONBAR_HEIGHT);
    }];
    
    self.navigationBottomLineView = [[UIView alloc] init];
    self.navigationBottomLineView.backgroundColor = HexColor(@"f1f1f1");
    [self.navigationView addSubview:self.navigationBottomLineView];
    [self.navigationBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.navigationView);
        make.bottom.equalTo(self.navigationView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    self.navigationBottomLineView.hidden = YES;
}

// 初始化一些东西
- (void)initSubviews {
    // TODO in the child-classes
}

- (void)setNavigationViewBackgroundColor:(UIColor *)color {
    [self setNavigationViewBackgroundColor:color shouldShowBottomLine:NO];
}

- (void)setNavigationViewBackgroundColor:(UIColor *)color shouldShowBottomLine:(BOOL)shouldShowBottomLine {
    self.navigationView.hidden = NO;
    self.navigationView.backgroundColor = color;
    
    self.navigationBottomLineView.hidden = !shouldShowBottomLine;
}

- (void)setNavigationBottomLineColor:(UIColor *)color {
    self.navigationBottomLineView.hidden = NO;
    self.navigationBottomLineView.backgroundColor = color;
}

- (void)showNavigationBottomLine:(BOOL)shouldShow {
    self.navigationBottomLineView.hidden = (!shouldShow);
}

- (void)hideNavigationView:(BOOL)shouldHide {
    self.navigationView.hidden = shouldHide;
    if (shouldHide) {
        self.navigationBottomLineView.hidden = YES;
    }
}

- (void)pushVC:(UIViewController *)nextVC {
    [self pushVC:nextVC animated:YES];
}

- (void)pushVC:(UIViewController *)nextVC animated:(BOOL)animated {
    if (self.navigationController) {
        [self.navigationController pushViewController:nextVC animated:animated];
    }
}

- (void)back {
    [self backAnimated:YES];
}

- (void)backAnimated:(BOOL)animated {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:animated];
    }
}

#pragma mark StatusBar

@end
