//
//  MacroOfTool.h
//  EES
//
//  Created by Albus on 18/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "UIColor+HexString.h"

#ifndef MacroOfTool_h
#define MacroOfTool_h


#define ScreenW     [[UIScreen mainScreen] bounds].size.width
#define ScreenH    [[UIScreen mainScreen] bounds].size.height

//获取主窗口
#define TheWindow [UIApplication sharedApplication].delegate.window

// HexColor
#define HexColor(hexStr) [UIColor colorWithHexString:hexStr]
#define HexColorAlpha(hexStr, alpha) [UIColor colorWithHexString:hexStr alpha:alpha]

// random color
#define RANDOM_COLOR [UIColor colorWithRed:(arc4random()%255/255.0) green:(arc4random()%255/255.0) blue:(arc4random()%255/255.0) alpha:1.0]

//是否是iPad
#define IS_IPAD [[UIDevice currentDevice].model isEqualToString:@"iPad"]
// 是否是4英寸屏幕
#define IS_SCREEN_4_0_INCH (SCREEN_WIDTH == 320.0)
// 是否是iPhoneX以上的机型
#define IS_IPHONEX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define NAVIGATIONBAR_HEIGHT  (IS_IPHONEX ? 88.0 : 64.0) //顶部导航栏h高度
#define TABBAR_HEIGHT         (IS_IPHONEX ? 83.0 : 49.0) //底部tabbar高度
#define XBOTTOM_HEIGHT        (IS_IPHONEX ? 34.0 : 0.0) //IphoneX底部高度
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

// 关于系统
#define IOS_VERSION   ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IS_IOS8_OR_LATER  (IOS_VERSION >= 8.0)
#define IS_IOS9_OR_LATER  (IOS_VERSION >= 9.0)
#define IS_IOS10_OR_LATER (IOS_VERSION >= 10.0)
#define IS_IOS11_OR_LATER (IOS_VERSION >= 11.0)
#define IS_IOS12_OR_LATER (IOS_VERSION >= 12.0)




#define WeakSelf(weakSelf)      __weak __typeof(&*self)    weakSelf  = self;    //弱引用
#define WS(weakSelf)      __weak __typeof(&*self)    weakSelf  = self;    //弱引用
#define StrongSelf(strongSelf)  __strong __typeof(&*self) strongSelf = weakSelf;//强引用

#endif /* MacroOfTool_h */
