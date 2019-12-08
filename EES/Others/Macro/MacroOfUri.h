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
// 故障报修
// 报修呼叫-加载产线
#define PROBLEM_REPORT_CHANXIAN_LIST @"BMRequestStateList/LoadLine"
// 报修呼叫-提交呼叫信息
#define PROBLEM_NEW_REPORT_SUBMIT_NEW_ITEM @"BMRequestStateList/CallComit"



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
// 根据工单编号查询工单信息
#define MAINTENANCE_PLAN_GET_ITEM_DETAIL @"SMWorkOrder/LoadWorkOrder"
// 根据id编号开始工单
#define MAINTENANCE_PLAN_GET_ACTION_START @"SMWorkOrder/StartWork"
// 根据id编号结束工单
#define MAINTENANCE_PLAN_GET_ACTION_END @"SMWorkOrder/EndWork"



// 班组点检
// 根据设备名称查询工单集合
#define GROUP_CHECK_GET_LIST @"CMSWorkOrder/LoadList"
// 根据计划号、工单号及点检状态（W表是未点检，P表示已点检，D表示异常）查询点检项目
#define GROUP_CHECK_GET_DETAIL_ITEM_LIST @"CMSWorkOrder/LoadWorkOrderProject"
// 根据计划号和工单号查询图片
#define GROUP_CHECK_GET_DETAIL_ITEM_ATTACHMENT @"CMSWorkOrder/LoadFiles"
// 根据填入的数据处理异常点检
#define GROUP_CHECK_ACTION_DETAIL_ITEM_UNCHECKED_SUBMIT @"CMSWorkOrder/Deal"
// 报工
#define GROUP_CHECK_ACTION_SUBMIT @"CMSWorkOrder/Commit"



// 　保全点检
// 根据设备名称查询工单集合
#define WHOLE_CHECK_GET_LIST @"CMAWorkOrder/LoadList"
// 根据计划号、工单号及点检状态（W表是未点检，P表示已点检，D表示异常）查询点检项目
#define WHOLE_CHECK_GET_DETAIL_ITEM_LIST @"CMAWorkOrder/LoadWorkOrderProject"
// 根据项目号查询当前点检项目情况
#define WHOLE_CHECK_GET_DETAIL_ITEM_DETIAL @"CMAWorkOrder/LoadWorkOrderProjectModel"
// 获取附件信息
#define WHOLE_CHECK_GET_DETAIL_ATTACHMENT_INFO @"CMAWorkOrder/LoadFiles"
// 提交异常处理内容
#define WHOLE_CHECK_ACTION_SUBMIT_EXCEPTION_CONTENT @"CMAWorkOrder/Deal"
// 上传现场拍照附件
#define WHOLE_CHECK_ACTION_UPLOAD_FILE @"CMAWorkOrder/Upload"


// 　保养辅料
// 根据辅料编号查询详细信息（支持扫码）
#define SEASONNING_MANAGEMENT_GET_DETAIL_BY_BARCODE @"ASAce/LoadDetail"
// 查询工程集合
#define SEASONNING_MANAGEMENT_GET_PROJECT_LIST @"ASAce/LoadSelProList"
// 查询机型集合
#define SEASONNING_MANAGEMENT_GET_JIXING_LIST @"ASAce/LoadSelItemList"
// 查询设备集合
#define SEASONNING_MANAGEMENT_GET_DEVICE_LIST @"ASAce/LoadSelList"
// 根据辅料编号上料
#define SEASONNING_MANAGEMENT_ACTION_SHANGLIAO @"ASAce/Loading"
// 根据辅料编号上料
#define SEASONNING_MANAGEMENT_ACTION_XIALIAO @"ASAce/Blanking"



#endif /* MacroOfUri_h */
