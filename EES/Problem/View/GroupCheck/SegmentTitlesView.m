//
//  SegmentTitlesView.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "SegmentTitlesView.h"

@interface SegmentTitlesView ()

@property (nonatomic, strong) UIView *indicatorLine;

@property (nonatomic, copy) NSArray *titles;

@end

@implementation SegmentTitlesView

- (void)initSubviews {
    self.indicatorLine = [[UIView alloc] init];
    self.indicatorLine.backgroundColor = HexColor(MAIN_COLOR);
    [self addSubview:self.indicatorLine];
    [self.indicatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(100);
    }];
}

- (void)resetSubviewsWithTitles:(NSArray *)titles {
    self.titles = titles;
    
    for (int i = 0; i < titles.count; i++) {
        
    }
}

@end
