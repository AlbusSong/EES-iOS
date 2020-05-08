//
//  MaintenanceDetailModel.h
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaintenanceDetailModel : NSObject

@property (nonatomic, copy) NSString *EquipCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *ReuqestTimeFormat;

@property (nonatomic, copy) NSString *LineName;

@property (nonatomic, copy) NSString *ResponseTimeLength;

@property (nonatomic, copy) NSString *BMRequestNO;

@property (nonatomic, copy) NSString *BMWorkOrderStateName;

@property (nonatomic, copy) NSString *BMWorkOrder;

@property (nonatomic, copy) NSString *BMTypeName;

@property (nonatomic, copy) NSString *RequestOperatorDesc;

@property (nonatomic, copy) NSString *ItemDesc;

@property (nonatomic, copy) NSString *RoleName;

@property (nonatomic, copy) NSString *QCRefuse;

@property (nonatomic, copy) NSString *QCRejectReason;

@property (nonatomic, copy) NSString *WorkOrderStarTime;

@property (nonatomic, copy) NSString *RequestTimeLenSS;

@property (nonatomic, copy) NSString *FaultStartTime;

@property (nonatomic, copy) NSString *BMEBoardStateDesc;

@property (nonatomic, copy) NSString *LevelDesc;

@property (nonatomic, copy) NSString *VendorRquestState;

@end

NS_ASSUME_NONNULL_END
