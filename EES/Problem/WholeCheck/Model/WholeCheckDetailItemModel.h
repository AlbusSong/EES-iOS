//
//  WholeCheckDetailItemModel.h
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WholeCheckDetailItemModel : NSObject

@property (nonatomic, copy) NSString *EquipCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *CMAProjectNo;

@property (nonatomic, copy) NSString *CMAPlanNo;

@property (nonatomic, copy) NSString *CMAWorkOrderNo;

@property (nonatomic, copy) NSString *WorkOrderNoApp;

@property (nonatomic, copy) NSString *Project;

@property (nonatomic, copy) NSString *Part;

@property (nonatomic, copy) NSString *Method;

@property (nonatomic, copy) NSString *AppResult;

@end

NS_ASSUME_NONNULL_END
