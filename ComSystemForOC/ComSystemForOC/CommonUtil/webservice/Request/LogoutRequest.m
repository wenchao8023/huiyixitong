//
//  LogoutRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/8.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "LogoutRequest.h"

@implementation LogoutRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=account&cmd=logout";
}

- (NSDictionary *)packageParams
{
    NSDictionary *paramDic = @{@"token"  : _token,};
    return paramDic;
}


@end
