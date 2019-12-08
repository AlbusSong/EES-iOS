//
//  ProblemWholeCheckSubmitSegmentControlCell.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProblemWholeCheckSubmitSegmentControlCellDelegate <NSObject>

@optional
- (void)segmentControlIndexHasChanged:(NSInteger)newIndex;

@end

@interface ProblemWholeCheckSubmitSegmentControlCell : ASTableViewCell

@property (nonatomic, weak) id <ProblemWholeCheckSubmitSegmentControlCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
