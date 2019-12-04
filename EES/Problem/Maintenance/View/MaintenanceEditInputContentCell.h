//
//  MaintenanceEditInputContentCell.h
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MaintenanceEditInputContentCellDelegate <NSObject>

@optional
- (void)contentHasChangedTo:(NSString *)newContent;

@end

@interface MaintenanceEditInputContentCell : ASTableViewCell

@property (nonatomic, weak) id <MaintenanceEditInputContentCellDelegate> delegate;

- (void)resetPlaceholder:(NSString *)placeholder;
- (void)resetTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
