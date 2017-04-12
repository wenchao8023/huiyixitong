//
//  CommonUtil.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/7.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil


+(void)saveUserID:(NSString *)userid {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:userid forKey:@"loginUserid"];
    
    [def synchronize];
}

+(NSString *)getUserID {
    
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"loginUserid"];
}

+(NSString *)getIconLabelStr:(NSString *)str {
    
    if (str.length <= 2) {
        return str;
        
    } else if (str.length <=3) {
        return [str substringFromIndex:1];
        
    } else if (str.length <= 4) {
        return [str substringFromIndex:2];
        
    } else {
        return [str substringToIndex:1];
    }
}

@end
