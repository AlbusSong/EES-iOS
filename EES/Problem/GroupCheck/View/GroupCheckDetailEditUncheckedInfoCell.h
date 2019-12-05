//
//  GroupCheckDetailEditUncheckedInfoCell.h
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class GroupCheckDetailItemModel;

@interface GroupCheckDetailEditUncheckedInfoCell : ASTableViewCell

- (void)resetSubviewsWithData:(GroupCheckDetailItemModel *)data;

@end

NS_ASSUME_NONNULL_END
