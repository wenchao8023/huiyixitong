//
//  CreateRoomRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/8.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "CreateRoomRequest.h"

@implementation CreateRoomRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=live&cmd=create";


}

- (NSDictionary *)packageParams
{
    NSDictionary *paramDic = @{@"token"  : _token,
                               @"type" : _type,
                               };
    return paramDic;
}

- (Class)responseDataClass
{
    return [CreateRoomResponceData class];
}

@end

@implementation CreateRoomResponceData


@end
