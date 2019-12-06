//
//  ProblemGroupCheckDetailItemCell.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProblemGroupCheckDetailItemCellDelegate <NSObject>

@optional
- (void)decisionHasChangedTo:(BOOL)isOkay atIndexPath:(NSIndexPath *)indexPath;
- (void)numberHasChangedTo:(NSString *)numberString atIndexPath:(NSIndexPath *)indexPath;

@end

@class GroupCheckDetailItemModel;

@interface ProblemGroupCheckDetailItemCell : ASTableViewCell

@property (nonatomic, weak) id <ProblemGroupCheckDetailItemCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)resetSubviewsWithData:(GroupCheckDetailItemModel *)data;

@end

NS_ASSUME_NONNULL_END
