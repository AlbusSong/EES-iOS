//
//  NSString+JSON.m
//  EES
//
//  Created by Albus on 2019-11-28.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "NSString+JSON.h"


@implementation NSString (JSON)

- (NSDictionary *)toDictionary {
    
    if (self.length == 0) {
        
        return nil;
        
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dict;
}

- (NSArray *)toArray {
    
    if (self.length == 0) {
        
        return nil;
        
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return array;
}

@end
