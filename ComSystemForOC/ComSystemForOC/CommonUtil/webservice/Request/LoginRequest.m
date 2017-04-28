//
//  LoginRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/11/30.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=account&cmd=login";
}

- (NSDictionary *)packageParams
{
    NSDictionary *paramDic = @{@"uname"  : _identifier,
                               @"pwd" : _pwd
                               };
    return paramDic;
}

- (Class)responseDataClass
{
    return [LoginResponceData class];
}

@end

@implementation LoginResponceData

@end
