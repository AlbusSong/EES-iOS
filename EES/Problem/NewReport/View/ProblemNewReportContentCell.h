//
//  ProblemNewReportContentCell.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemNewReportSelectionCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProblemNewReportContentCellDelegate <NSObject>

@optional
- (void)contentHasChangedTo:(NSString *)newContent;

@end

@interface ProblemNewReportContentCell : ProblemNewReportSelectionCell

@property (nonatomic, weak) id<ProblemNewReportContentCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
