//
//  GroupCheckDetailItemModel.h
//  EES
//
//  Created by Albus on 2019-12-05.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupCheckDetailItemModel : NSObject

@property (nonatomic, copy) NSString *Project;

@property (nonatomic, copy) NSString *JudgeType;

@property (nonatomic, copy) NSString *AppStandard;

@property (nonatomic, copy) NSString *MethodTool;

@property (nonatomic, copy) NSString *AttachName;

@property (nonatomic, copy) NSString *CMSProjectNo;
//
@property (nonatomic, copy) NSString *WorkOrderNoApp;
//
@property (nonatomic, copy) NSString *AppResult;

@property (nonatomic, copy) NSString *Result;

@property (nonatomic, copy) NSString *Unit;

@property (nonatomic, copy) NSString *Comment;

@property (nonatomic, copy) NSString *AppIsSolve;

@property (nonatomic, copy) NSString *Actual;

@end

NS_ASSUME_NONNULL_END
