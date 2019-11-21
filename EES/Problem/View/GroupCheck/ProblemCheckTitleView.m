//
//  ProblemCheckTitleView.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemCheckTitleView.h"

@interface ProblemCheckTitleView ()

@property (nonatomic, strong) UIView *indicatorLine;

@property (nonatomic) NSInteger selectedIndex;

@end

@implementation ProblemCheckTitleView

- (void)initSubviews {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClicked:)]];
    
    self.indicatorLine = [[UIView alloc] init];
    self.indicatorLine.backgroundColor = HexColor(MAIN_COLOR);
    [self addSubview:self.indicatorLine];
    [self.indicatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2);
        make.bottom.offset(-3);
    }];
    
    NSArray *arrOfTitle = @[@"未点检", @"已点检", @"异常"];
    for (int i = 0; i < arrOfTitle.count; i++) {
        UILabel *txtOfSegment = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:17] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self];
        txtOfSegment.text = arrOfTitle[i];
        txtOfSegment.tag = 10000 + i;
        
        [txtOfSegment mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.offset(10);
            } else if (i == 1) {
                make.centerX.equalTo(self);
            } else if (i == 2) {
                make.right.offset(-2);
            }
            make.top.bottom.equalTo(self);
        }];
        
        if (i == 0) {
            [self.indicatorLine mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(txtOfSegment.mas_left);
                make.right.equalTo(txtOfSegment.mas_right);
                make.height.mas_equalTo(2);
                make.bottom.offset(-3);
            }];
        }
    }
}

#pragma mark actions

- (void)tryToSelectSegmentAtIndex:(NSInteger)index {
    if (index == self.selectedIndex) {
        return;
    }
    
    self.selectedIndex = index;
    UILabel *txtOfSelectedSegment = (UILabel *)[self viewWithTag:(10000 + index)];
    [self.indicatorLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(txtOfSelectedSegment.mas_left);
        make.right.equalTo(txtOfSelectedSegment.mas_right);
        make.height.mas_equalTo(2);
        make.bottom.offset(-3);
    }];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hasSelectedSegmentAtIndex:)]) {
        [self.delegate hasSelectedSegmentAtIndex:index];
    }
}

#pragma mark gestures

- (void)onClicked:(UITapGestureRecognizer *)sender {
    CGFloat pointX = [sender locationInView:self].x;
    CGFloat ratio = pointX/ScreenW;
    NSLog(@"ratio: %f, %d", ratio, (int)(ratio*3));
    [self tryToSelectSegmentAtIndex:(NSInteger)(ratio*3)];
}

@end
