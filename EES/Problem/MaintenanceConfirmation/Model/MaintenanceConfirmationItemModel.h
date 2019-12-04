//
//  MaintenanceConfirmationItemModel.h
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaintenanceConfirmationItemModel : NSObject

@property (nonatomic, copy) NSString *EquipCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *LineName;

@property (nonatomic, copy) NSString *RoleName;

// 报工人员
@property (nonatomic, copy) NSString *RequestOperatorDesc;

// 对策
@property (nonatomic, copy) NSString *PrestRemark;

// 报工时间
@property (nonatomic, copy) NSString *WorkOrderEndTime;

@property (nonatomic, copy) NSString *BMRequestNO;

@property (nonatomic, copy) NSString *ItemDesc;

@property (nonatomic, copy) NSString *BMTypeName;

@property (nonatomic, copy) NSString *ReuqestTimeFormat;

@property (nonatomic, copy) NSString *ApprovalState;

@end

NS_ASSUME_NONNULL_END
