//
//  FadeInFadeOutView.m
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "FadeInFadeOutView.h"

@implementation FadeInFadeOutView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.shouldFadeInFadeOutSelf = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.shouldFadeInFadeOutSelf = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setSubviewsAlpha:0.2];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setSubviewsAlpha:1.0];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setSubviewsAlpha:1.0];
}

- (void)setSubviewsAlpha:(CGFloat)alpha {
    [UIView animateWithDuration:0.2 animations:^(void){
        if (self.shouldFadeInFadeOutSelf) {
            self.alpha = alpha;
        } else {
            for (UIView *view in self.subviews) {
                if (![self.arrOfExemptView containsObject:view]) {
                    view.alpha = alpha;
                }
            }
        }
    }];
}

#pragma mark getter

- (NSMutableArray *)arrOfExemptView {
    if (_arrOfExemptView == nil) {
        _arrOfExemptView = [[NSMutableArray alloc] init];
    }
    return _arrOfExemptView;
}

@end
