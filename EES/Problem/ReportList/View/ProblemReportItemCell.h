//
//  ProblemReportItemCell.h
//  EES
//
//  Created by Albus on 20/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"
#import "ReportListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProblemReportItemCell : ASTableViewCell

- (void)resetSubviewsWithData:(ReportListItemModel *)data;

- (void)showSelected:(BOOL)ifSelected;

@end

NS_ASSUME_NONNULL_END
