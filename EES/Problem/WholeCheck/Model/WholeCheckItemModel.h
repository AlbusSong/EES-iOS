//
//  WholeCheckItemModel.h
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 ;. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WholeCheckItemModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *EquipCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *LineName;

@property (nonatomic, copy) NSString *CMAPlanNo;

@property (nonatomic, copy) NSString *CMAWorkOrderNo;

@property (nonatomic, copy) NSString *CMTypeApp;

@property (nonatomic, copy) NSString *PlanTimeApp;

@property (nonatomic, copy) NSString *WorkOrderState;

@property (nonatomic, copy) NSString *WorkOrderStateApp;

@end

NS_ASSUME_NONNULL_END
