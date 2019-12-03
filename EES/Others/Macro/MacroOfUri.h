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

// 报修接受
#define REPORT_ITEM_ACCEPT @"BMRequestStateList/Accept"

// 报修拒绝
#define REPORT_ITEM_DECLINE @"BMRequestStateList/Refuse"


// 故障报修
// 报修呼叫-加载产线
#define PROBLEM_REPORT_CHANXIAN_LIST @"BMRequestStateList/LoadLine"

#endif /* MacroOfUri_h */
