//
//  ProblemMaintenanceDetailReportInfoCell.h
//  EES
//
//  Created by Albus on 2019-11-20.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class MaintenanceDetailModel;

@interface ProblemMaintenanceDetailReportInfoCell : ASTableViewCell

- (void)resetSubviewsWithData:(MaintenanceDetailModel *)data;

@end

NS_ASSUME_NONNULL_END
