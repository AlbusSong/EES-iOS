//
//  ProblemWholeCheckItemCell.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class WholeCheckItemModel;

@interface ProblemWholeCheckItemCell : ASTableViewCell

- (void)resetSubviewsWithData:(WholeCheckItemModel *)data;

@end

NS_ASSUME_NONNULL_END
