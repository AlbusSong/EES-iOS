//
//  MacroOfUri.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#ifndef MacroOfUri_h
#define MacroOfUri_h

#define BASE_URL @"http://oscarzq.51vip.biz:51593/"
//#define BASE_URL @"https://58.210.106.178:4433/"


// 登陆
//#define LOGIN @"Login/Online"
#define LOGIN @"Login/OutOnline"

// 首页各功能条数
#define HOME_FUNCTION_MODULES @"MainPage/LoadCount"



// 加载报修呼叫列表
#define PROBLEM_REPORT_LIST @"BMRequestStateList/LoadList"
// 报修接受
#define REPORT_ITEM_ACCEPT @"BMRequestStateList/Accept"
// 报修拒绝
#define REPORT_ITEM_DECLINE @"BMRequestStateList/Refuse"



// 加载报修呼叫列表
#define GET_REPORT_LIST @"BMRequestStateList/LoadList"
// 报修呼叫-加载设备
#define GET_DEVICE_LIST @"BMRequestStateList/LoadEquip"
// 报修呼叫-加载维修角色
#define GET_MAINTENANCE_ROLE_LIST @"BMRequestStateList/LoadRole"
// 报修呼叫-加载故障等级
#define GET_PROBLEM_LEVEL_LIST @"BMRequestStateList/LoadLevel"
// 报修呼叫-加载故障现象代码
#define GET_PROBLEM_DESC_LIST @"BMRequestStateList/LoadItemCode"



// 加载故障工单列表
#define MAINTENANCE_GET_LIST @"WorkOrderState/LoadList"
// 加载故障工单明细
#define MAINTENANCE_GET_ITEM_DETAIL @"WorkOrderState/Detailed"
//  故障工单-工单开始
#define MAINTENANCE_ACTION_START @"WorkOrderState/Start"
// 故障工单-故障等级修改
#define MAINTENANCE_ACTION_CHANGE_LEVEL @"WorkOrderState/Level"
// 故障工单-维修角色修改
#define MAINTENANCE_ACTION_CHANGE_ROLE @"WorkOrderState/Role"
// 故障工单-委外申请
#define MAINTENANCE_ACTION_WEIWAI_APPLY @"WorkOrderState/Vendor"
//  故障工单-报工
#define MAINTENANCE_ACTION_REPORT @"WorkOrderState/End"
// 报修呼叫-加载故障等级
#define MAINTENANCE_GET_LEVEL_LIST @"BMRequestStateList/LoadLevel"
// 报修呼叫-加载维修角色
#define MAINTENANCE_GET_ROLE_LIST @"BMRequestStateList/LoadRole"
// 报修呼叫-加载FailCode
#define MAINTENANCE_GET_FAILCODE_LIST @"BMRequestStateList/LoadFailCode"



// 加载故障工单审核列表
#define MAINTENANCE_CONFIRMATION_GET_LIST @"WorkOrderStateQC/LoadList"
// 通过
#define MAINTENANCE_CONFIRMATION_ACTION_APPROVE @"WorkOrderStateQC/Accept"
// 驳回
#define MAINTENANCE_CONFIRMATION_ACTION_REJECT @"WorkOrderStateQC/Refuse"





// 　定期保养列表
#define PERIODICAL_MAINTENANCE_GET_LIST @"PMWorkOrder/LoadList"
// 根据工单编号查询工单信息
#define PERIODICAL_MAINTENANCE_GET_DETAIL @"PMWorkOrder/LoadWorkOrder"
// 根据计划编号查询附件
#define PERIODICAL_MAINTENANCE_GET_ATTACHMENT @"PMWorkOrder/LoadFiles"
// 根据工单编号开始工单
#define PERIODICAL_MAINTENANCE_ACTION_START @"PMWorkOrder/StartWork"
// 根据工单编号结束工单
#define PERIODICAL_MAINTENANCE_ACTION_END @"PMWorkOrder/EndWork"



// 　计划维修
// 查询工单集合
#define MAINTENANCE_PLAN_GET_LIST @"SMWorkOrder/LoadList"


// 故障报修
// 报修呼叫-加载产线
#define PROBLEM_REPORT_CHANXIAN_LIST @"BMRequestStateList/LoadLine"

#endif /* MacroOfUri_h */
