//
//  BasePageVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BasePageVC.h"

@interface BasePageVC () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIViewController *nextVC;

@end

@implementation BasePageVC

- (instancetype)initWithArrOfContentVC:(NSArray <UIViewController *> *)arrOfContentVC {
    //    if (arrOfContentVC.count == 0) {
    //        return nil;
    //    }
    
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(20)}];
    if (self) {
        self.arrOfContentVC = arrOfContentVC;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.delegate = self;
    self.dataSource = self;
    
    if ([self.arrOfContentVC firstObject]) {
        [self setViewControllers:@[self.arrOfContentVC.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    self.lastSeletedIndex = 0;
    
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            scrollView.delegate = self;
            scrollView.pagingEnabled = YES;
        }
    }
}

#pragma mark action

- (void)selectVCAtIndex:(NSInteger)index {
    if (index >= self.arrOfContentVC.count) {
        return;
    }
    
    if (index < 0) {
        return;
    }
    
    [self setViewControllers:@[[self.arrOfContentVC objectAtIndex:index]] direction:(index > self.lastSeletedIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse) animated:YES completion:nil];
    self.lastSeletedIndex = index;
}

#pragma mark - UIPageViewControllerDataSource And UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.arrOfContentVC indexOfObject:viewController];
    NSInteger previousIndex = (index - 1);
    if (previousIndex < 0) {
        return nil;
    } else {
        return [self.arrOfContentVC objectAtIndex:previousIndex];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.arrOfContentVC indexOfObject:viewController];
    NSInteger nextIndex = (index + 1);
    if (nextIndex >= self.arrOfContentVC.count) {
        return nil;
    } else {
        return [self.arrOfContentVC objectAtIndex:nextIndex];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    if (pendingViewControllers.count == 0) {
        self.nextVC = nil;
        return;
    } else {
        self.nextVC = pendingViewControllers.firstObject;
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        if (self.nextVC == nil) {
            return;
        }
        
        if (![self.arrOfContentVC containsObject:self.nextVC]) {
            return;
        }
        
        NSInteger index = [self.arrOfContentVC indexOfObject:self.nextVC];
        if (self.scrollDelegate && [self.scrollDelegate respondsToSelector:@selector(hasScrollToIndex:)]) {
            [self.scrollDelegate hasScrollToIndex:index];
        }
    } else {
        self.nextVC = nil;
    }
}

//- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
//    return UIInterfaceOrientationPortrait;
//}

#pragma mark setting

- (void)setArrOfContentVC:(NSArray *)arrOfContentVC {
    _arrOfContentVC = [arrOfContentVC copy];
    
    if ([_arrOfContentVC firstObject]) {
        [self setViewControllers:@[_arrOfContentVC.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

@end
