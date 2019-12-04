//
//  GroupCheckItemModel.h
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupCheckItemModel : NSObject

@property (nonatomic, copy) NSString *EquipCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *LineName;

@property (nonatomic, copy) NSString *CMSWorkOrderNo;

@property (nonatomic, copy) NSString *CMSPlanNo;

@property (nonatomic, copy) NSString *EndTimeApp;

@property (nonatomic, copy) NSString *StartTimeApp;

@property (nonatomic, copy) NSString *WorkOrderState;

@end

NS_ASSUME_NONNULL_END
