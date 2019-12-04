//
//  ProblemMaintenanceItemCell.h
//  EES
//
//  Created by Albus on 2019-11-20.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"
#import "MaintenanceItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProblemMaintenanceItemCell : ASTableViewCell

- (void)resetSubviewsWithData:(MaintenanceItemModel *)data;

@end

NS_ASSUME_NONNULL_END
