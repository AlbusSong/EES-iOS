//
//  ProblemWholeCheckSubmitSegmentControlCell.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemWholeCheckSubmitSegmentControlCell.h"

@interface ProblemWholeCheckSubmitSegmentControlCell ()

@property (nonatomic, strong) UILabel *txtOfTitle;

@property (nonatomic, strong) UISegmentedControl *smcOfResult;

@end

@implementation ProblemWholeCheckSubmitSegmentControlCell

- (void)initSubviews {
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:18] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(25);
        make.left.offset(10);
        make.top.offset(5);
    }];
    self.txtOfTitle.text = @"结果:";
    
    self.smcOfResult = [[UISegmentedControl alloc] initWithItems:@[@"OK", @"NG已改善", @"NG未改善"]];
    [self.smcOfResult addTarget:self action:@selector(smcOfResultClicked:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.smcOfResult];
    [self.smcOfResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.txtOfTitle.mas_bottom).offset(10);
        make.bottom.offset(-10);
    }];
}

#pragma mark gestures

- (void)smcOfResultClicked:(UISegmentedControl *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControlIndexHasChanged:)]) {
        [self.delegate segmentControlIndexHasChanged:sender.selectedSegmentIndex];
    }
}

@end
