//
//  MaintenanceEditInputSelectionCell.h
//  EES
//
//  Created by Albus on 2019-12-04.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MaintenanceEditInputSelectionCell : ASTableViewCell

- (void)resetTitle:(NSString *)title;
- (void)setContent:(NSString *)content;
- (void)showInputArea:(BOOL)shouldShow;

@end

NS_ASSUME_NONNULL_END
