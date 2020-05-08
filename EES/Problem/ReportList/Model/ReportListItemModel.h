//
//  ReportListItemModel.h
//  EES
//
//  Created by Albus on 2019-12-03.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReportListItemModel : NSObject

@property (nonatomic, copy) NSString *EquipCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *LineName;

@property (nonatomic, copy) NSString *RoleName;

@property (nonatomic, copy) NSString *BMRequestNO;

@property (nonatomic, copy) NSString *ItemDesc;

@property (nonatomic, copy) NSString *BMTypeName;

@property (nonatomic, copy) NSString *ReuqestTimeFormat;

@property (nonatomic, copy) NSString *ApprovalState;

@property (nonatomic, copy) NSString *RequestOperator;

@end

NS_ASSUME_NONNULL_END
