//
//  ProblemMaintenancePlanDetailVC.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@class MaintenancePlanItemModel;

@interface ProblemMaintenancePlanDetailVC : BaseTableVC

@property (nonatomic, strong) MaintenancePlanItemModel *data;

@end

NS_ASSUME_NONNULL_END
