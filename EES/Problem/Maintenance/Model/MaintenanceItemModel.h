//
//  MaintenanceItemModel.h
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaintenanceItemModel : NSObject

@property (nonatomic, copy) NSString *EquipCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *ReuqestTimeFormat;

@property (nonatomic, copy) NSString *LineName;

@property (nonatomic, copy) NSString *ResponseTimeLength;

@property (nonatomic, copy) NSString *BMRequestNO;

@property (nonatomic, copy) NSString *BMWorkOrderStateName;

@end

NS_ASSUME_NONNULL_END
