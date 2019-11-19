//
//  MacroOfEnum.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef MacroOfEnum_h
#define MacroOfEnum_h

// 网络链接状态
typedef NS_ENUM(NSInteger, NetworkStatus) {
    NetworkStatusAvailable = 0,
    NetworkStatusAvailableWifi,
    NetworkStatusAvailableCeller,
    NetworkStatusUnavailable
};


#endif /* MacroOfEnum_h */
