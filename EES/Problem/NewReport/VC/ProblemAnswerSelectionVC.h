//
//  ProblemAnswerSelectionVC.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProblemAnswerSelectionVC : BaseVC

@property (nonatomic, copy) void (^cancelBlock) (void);

@property (nonatomic, copy) void (^confirmationBlock) (NSInteger index, NSString *title);

@property (nonatomic, copy) NSArray *arrOfData;

@end

NS_ASSUME_NONNULL_END
