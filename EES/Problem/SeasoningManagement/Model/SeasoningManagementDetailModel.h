//
//  SeasoningManagementDetailModel.h
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeasoningManagementDetailModel : NSObject

@property (nonatomic, copy) NSString *ASCK;

@property (nonatomic, copy) NSString *ASCode;

@property (nonatomic, copy) NSString *EquipName;

@property (nonatomic, copy) NSString *Item;
//
@property (nonatomic, copy) NSString *Name;
//
@property (nonatomic, copy) NSString *VendorName;
//
@property (nonatomic, copy) NSString *Manufacturer;

@property (nonatomic, copy) NSString *ActUseCount;

@property (nonatomic, copy) NSString *UsePartType1;

@property (nonatomic, copy) NSString *UsePart;

@property (nonatomic, copy) NSString *ASStatus;

@end

NS_ASSUME_NONNULL_END
