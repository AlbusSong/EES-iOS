//
//  BaseTableVC.h
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableVC : BaseVC <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ASTableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrOfData;

@property (nonatomic) NSUInteger currentPage;

@end

NS_ASSUME_NONNULL_END
