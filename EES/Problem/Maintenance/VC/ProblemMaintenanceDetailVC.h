//
//  ProblemMaintenanceDetailVC.h
//  EES
//
//  Created by Albus on 2019-11-20.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@class MaintenanceItemModel;

@interface ProblemMaintenanceDetailVC : BaseTableVC

@property (nonatomic, strong) MaintenanceItemModel *data;

@end

NS_ASSUME_NONNULL_END
