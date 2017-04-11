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

@end
