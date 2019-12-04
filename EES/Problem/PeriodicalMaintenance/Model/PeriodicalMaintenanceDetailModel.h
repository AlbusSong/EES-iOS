//
//  PeriodicalMaintenanceDetailModel.h
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PeriodicalMaintenanceDetailModel : NSObject

@property (nonatomic, copy) NSString *EquipCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *LineName;

@property (nonatomic, copy) NSString *RoleName;

@property (nonatomic, copy) NSString *WorkOrderState1;

@property (nonatomic, copy) NSString *Item;

@property (nonatomic, copy) NSString *InitialDate;

@property (nonatomic, copy) NSString *PlanDate;

@property (nonatomic, copy) NSString *WorkOrderPlanDate1;

@property (nonatomic, copy) NSString *PMWorkOrderNo;

@property (nonatomic, copy) NSString *PMTypeName;

@property (nonatomic, copy) NSString *Method;
//
@property (nonatomic, copy) NSString *Detail;
//
@property (nonatomic, copy) NSString *Stardard;

@property (nonatomic, copy) NSString *VendorMaintanceDay;

@property (nonatomic, copy) NSString *PMPlanNO;

@end

NS_ASSUME_NONNULL_END
