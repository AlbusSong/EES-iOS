//
//  ProblemWholeCheckSubmitInfoCell.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class WholeCheckDetailItemDetailModel;

@interface ProblemWholeCheckSubmitInfoCell : ASTableViewCell

- (void)resetSubviewsWithData:(WholeCheckDetailItemDetailModel *)data;
- (void)resetAttachmentInfo:(NSString *)attachmentInfo;
- (void)showPhenomenonAndStrategy:(BOOL)shouldShow;

@end

NS_ASSUME_NONNULL_END
