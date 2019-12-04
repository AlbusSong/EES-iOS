//
//  ProblemMaintenanceEditInfoVC.h
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@class MaintenanceDetailModel;

typedef NS_ENUM(NSInteger, MaintenanceEditInfoType) {
    MaintenanceEditInfoType_ChangeLevel = 1,
    MaintenanceEditInfoType_ChangeRole,
    MaintenanceEditInfoType_WeiwaiApply,
    MaintenanceEditInfoType_Report,
};

@interface ProblemMaintenanceEditInfoVC : BaseTableVC

@property (nonatomic, strong) MaintenanceDetailModel *detailData;

@property (nonatomic) MaintenanceEditInfoType editInfoType;

@end

NS_ASSUME_NONNULL_END
