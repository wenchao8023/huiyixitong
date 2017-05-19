//
//  ReportMemIdRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/9.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "ReportMemIdRequest.h"

@implementation ReportMemIdRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=live&cmd=reportmemid";
}

- (NSDictionary *)packageParams
{
    if (_token == nil && _userId == nil)
    {
        NSString *info = [NSString stringWithFormat:@"token=%@,userid=%@,fun=%s",_token,_userId,__func__];
        [[ILiveSDK getInstance] iLivelog:ILive_LOG_DEBUG tag:@"TILLiveSDKShow" msg:info];
        return nil;
    }
    NSDictionary *dic = @{@"token" : _token,
                          @"id" : _userId,
                          @"roomnum" : [NSNumber numberWithInteger:_roomnum],
                          @"role" : [NSNumber numberWithInteger:_role],
                          @"operate" : [NSNumber numberWithInteger:_operate],
                          };
    return dic;
}

@end
