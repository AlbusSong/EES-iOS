//
//  ProblemNewReportSelectionCell.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProblemNewReportSelectionCell : ASTableViewCell

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UILabel *txtOfContent;

@property (nonatomic, strong) UIImageView *imgvOfSmallTriangle;


- (void)showHilighted:(BOOL)shouldHighlight;

- (void)resetTitle:(NSString *)title;

- (void)setContent:(NSString *)content;

- (void)setPlaceholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
