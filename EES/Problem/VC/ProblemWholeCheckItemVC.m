//
//  ProblemWholeCheckItemVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckItemVC.h"
#import "ProblemCheckTitleView.h"

#import "ProblemWholeCheckDetailVC.h"

@interface ProblemWholeCheckItemVC ()<BasePageVCDelegate, ProblemCheckTitleViewDelegate>

@property (nonatomic, strong) ProblemCheckTitleView *titleView;

@property (nonatomic, strong) BasePageVC *pageVC;

@end

@implementation ProblemWholeCheckItemVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"保全点检";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleView = [[ProblemCheckTitleView alloc] init];
    self.titleView.backgroundColor = HexColor(@"f1f1f1");
    self.titleView.delegate = self;
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    NSMutableArray *arrOfContentVC = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        ProblemWholeCheckDetailVC *vcOfContnt = [[ProblemWholeCheckDetailVC alloc] init];
        vcOfContnt.state = i;
        [arrOfContentVC addObject:vcOfContnt];
    }
    
    self.pageVC = [[BasePageVC alloc] initWithArrOfContentVC:arrOfContentVC];
    self.pageVC.view.backgroundColor = HexColor(@"f1f1f1");
    self.pageVC.scrollDelegate = self;
    self.pageVC.view.frame = CGRectMake(0, 40, ScreenW, ScreenH - XBOTTOM_HEIGHT - 40);
    [self.view addSubview:self.pageVC.view];
    [self addChildViewController:self.pageVC];
}

#pragma mark ProblemCheckTitleViewDelegate

- (void)hasSelectedSegmentAtIndex:(NSInteger)index {
    [self.pageVC selectVCAtIndex:index];
}

#pragma mark BasePageVCDelegate

- (void)hasScrollToIndex:(NSInteger)index {
    [self.titleView tryToSelectSegmentAtIndex:index];
}

@end
