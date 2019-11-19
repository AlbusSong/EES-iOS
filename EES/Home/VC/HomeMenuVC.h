//
//  HomeMenuVC.h
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeMenuVC : BaseTableVC

@property (nonatomic, copy) void (^blockOfGoingToFunctions) (void);

@end

NS_ASSUME_NONNULL_END
