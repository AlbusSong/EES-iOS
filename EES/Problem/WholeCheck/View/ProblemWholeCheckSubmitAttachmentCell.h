//
//  ProblemWholeCheckSubmitAttachmentCell.h
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProblemWholeCheckSubmitAttachmentCellDelegate <NSObject>

@optional
- (void)tryToChooseFile;

@end

@interface ProblemWholeCheckSubmitAttachmentCell : ASTableViewCell

@property (nonatomic, weak) id <ProblemWholeCheckSubmitAttachmentCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
