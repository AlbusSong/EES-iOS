//
//  MaintenanceEditInfoFailCodeModel.h
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaintenanceEditInfoFailCodeModel : NSObject

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *BDCCode;

@property (nonatomic, copy) NSString *BDCID;

@end

NS_ASSUME_NONNULL_END
