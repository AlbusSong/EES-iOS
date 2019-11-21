//
//  ProblemGroupCheckItemVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemGroupCheckItemVC.h"
#import "ProblemCheckTitleView.h"

@interface ProblemGroupCheckItemVC () <ProblemCheckTitleViewDelegate>

@end

@implementation ProblemGroupCheckItemVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"班组点检";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ProblemCheckTitleView *titleView = [[ProblemCheckTitleView alloc] init];
    titleView.backgroundColor = HexColor(@"f1f1f1");
    titleView.delegate = self;
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark ProblemCheckTitleViewDelegate

- (void)hasSelectedSegmentAtIndex:(NSInteger)index {
    
}

@end
