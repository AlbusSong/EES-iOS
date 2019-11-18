//
//  FadeInFadeOutView.h
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FadeInFadeOutView : ASView

@property (nonatomic, strong) NSMutableArray *arrOfExemptView;

@property (nonatomic) BOOL shouldFadeInFadeOutSelf;

- (void)setSubviewsAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
