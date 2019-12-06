//
//  SeasoningManagementFirstCell.h
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class SeasoningManagementDetailModel;

@interface SeasoningManagementFirstCell : ASTableViewCell

- (void)resetSubviewsWithData:(SeasoningManagementDetailModel *)data;

@end

NS_ASSUME_NONNULL_END
