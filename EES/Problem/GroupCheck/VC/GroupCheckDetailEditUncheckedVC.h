//
//  GroupCheckDetailEditUncheckedVC.h
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@class GroupCheckDetailItemModel;

@interface GroupCheckDetailEditUncheckedVC : BaseTableVC

@property (nonatomic, strong) GroupCheckDetailItemModel *data;

@property (nonatomic) NSInteger state;

@end

NS_ASSUME_NONNULL_END
