//
//  ProblemCheckTitleView.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProblemCheckTitleViewDelegate <NSObject>

@optional
- (void)hasSelectedSegmentAtIndex:(NSInteger)index;

@end

@interface ProblemCheckTitleView : ASView

@property (nonatomic, weak) id <ProblemCheckTitleViewDelegate> delegate;


- (void)tryToSelectSegmentAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
