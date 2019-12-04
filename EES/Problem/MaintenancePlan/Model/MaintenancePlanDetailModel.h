//
//  MaintenancePlanDetailModel.h
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaintenancePlanDetailModel : NSObject

@property (nonatomic, copy) NSString *EquipCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *LineName;

@property (nonatomic, copy) NSString *RoleName;

@property (nonatomic, copy) NSString *WorkOrderNo;

@property (nonatomic, copy) NSString *WorkOrderState;

@property (nonatomic, copy) NSString *SMItem;

@property (nonatomic, copy) NSString *PlanDate1;

@end

NS_ASSUME_NONNULL_END
