//
//  ProblemMaintenancePlanItemCell.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class MaintenancePlanItemModel;

@interface ProblemMaintenancePlanItemCell : ASTableViewCell

- (void)resetSubviewsWithData:(MaintenancePlanItemModel *)data;

@end

NS_ASSUME_NONNULL_END
