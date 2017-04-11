//
//  HostHeartBeatRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/9.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "HostHeartBeatRequest.h"

@implementation HostHeartBeatRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=live&cmd=heartbeat";
}

- (NSDictionary *)packageParams
{
    NSDictionary *dic = @{@"token" : _token,
                          @"roomnum" : [NSNumber numberWithInteger:_roomnum],
                          @"role" : [NSNumber numberWithInt:_role],
                          @"thumbup" : [NSNumber numberWithInt:_thumbup],
                          };
    return dic;
}
@end
