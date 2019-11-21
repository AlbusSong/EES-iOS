//
//  BasePageVC.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BasePageVCDelegate <NSObject>

@optional
- (void)hasScrollToIndex:(NSInteger)index;

@end


@interface BasePageVC : UIPageViewController

@property (nonatomic, copy) NSArray *arrOfContentVC;
@property (nonatomic, weak) id<BasePageVCDelegate> scrollDelegate;
@property (nonatomic) NSInteger lastSeletedIndex;

- (instancetype)initWithArrOfContentVC:(NSArray <UIViewController *> *)arrOfContentVC;

- (void)selectVCAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
