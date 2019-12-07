//
//  ProblemWholeCheckSubmitVC.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@class WholeCheckDetailItemModel;

@interface ProblemWholeCheckSubmitVC : BaseTableVC

@property (nonatomic) NSInteger state;

@property (nonatomic, strong) WholeCheckDetailItemModel *data;

@end

NS_ASSUME_NONNULL_END
