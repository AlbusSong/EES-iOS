//
//  ProblemGroupCheckDetailUncheckedItemCell.h
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@class GroupCheckDetailItemModel;

@interface ProblemGroupCheckDetailUncheckedItemCell : ASTableViewCell

- (void)resetSubviewsWithData:(GroupCheckDetailItemModel *)data;

- (void)shouldShowProgressInfo:(BOOL)shouldShow;

@end

NS_ASSUME_NONNULL_END
