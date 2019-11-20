//
//  ProblemSearchBar.h
//  EES
//
//  Created by Albus on 20/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProblemSearchBarDelegate <NSObject>

@optional
- (void)searchContentChangedTo:(NSString *)newSearchContent;
- (void)tryToSearch;

@end

@interface ProblemSearchBar : ASView

@property (nonatomic, weak) id <ProblemSearchBarDelegate> delegate;

- (void)setSearchHint:(NSString *)hintString;

@end

NS_ASSUME_NONNULL_END
