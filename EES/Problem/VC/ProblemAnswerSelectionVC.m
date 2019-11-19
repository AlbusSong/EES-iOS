//
//  ProblemAnswerSelectionVC.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemAnswerSelectionVC.h"

@interface ProblemAnswerSelectionVC () <UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *wrapperView;

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation ProblemAnswerSelectionVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClicked:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    [self initSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self showAnimated];
}

#pragma mark init subviews

- (void)initSubviews {
    self.wrapperView = [[UIView alloc] init];
    self.wrapperView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.wrapperView];
    CGFloat heightOfWrapper = XBOTTOM_HEIGHT + 215 + 40;
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(heightOfWrapper);
        make.bottom.offset(heightOfWrapper);
    }];
    
    UIView *functionBar = [[UIView alloc] init];
    functionBar.backgroundColor = HexColor(@"f0f0f0");
    [self.wrapperView addSubview:functionBar];
    [functionBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(40);
    }];
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    btnCancel.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btnCancel.tintColor = HexColor(@"909090");
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnCancelClicked) forControlEvents:UIControlEventTouchUpInside];
    [functionBar addSubview:btnCancel];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.bottom.equalTo(functionBar);
    }];
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeSystem];
    btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btnConfirm.tintColor = HexColor(MAIN_COLOR);
    [btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
    [btnConfirm addTarget:self action:@selector(btnConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
    [functionBar addSubview:btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.bottom.equalTo(functionBar);
    }];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self.wrapperView addSubview:self.pickerView];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(functionBar.mas_bottom);
        make.height.mas_equalTo(215);
    }];
}

#pragma mark gestures

- (void)backgroundClicked:(UITapGestureRecognizer *)sender {
    [self btnCancelClicked];
}

- (void)btnCancelClicked {
    [self hideAnimated];
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)btnConfirmClicked {
    [self hideAnimated];
    
    if (self.confirmationBlock) {
        self.confirmationBlock(@"1");
    }
}

#pragma mark actions

- (void)hideAnimated {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        
        CGFloat heightOfWrapper = XBOTTOM_HEIGHT + 215 + 40;
        [self.wrapperView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(heightOfWrapper);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)showAnimated {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        [self.wrapperView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(0);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 20;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"1";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.wrapperView]) {
        return NO;
    }
    
    return YES;
}

@end
