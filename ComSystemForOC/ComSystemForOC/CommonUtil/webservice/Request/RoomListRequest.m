//
//  RoomListRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/9.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "RoomListRequest.h"

@implementation RoomListRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=live&cmd=roomlist";
}

- (NSDictionary *)packageParams
{
    NSDictionary *dic = @{@"token" : _token,
                              @"type" : _type,
                              @"index" : [NSNumber numberWithInteger:_index],
                              @"size" : [NSNumber numberWithInteger:_size],
                              @"appid" : [NSNumber numberWithInteger:_appid],
                          };
    return dic;
}

- (Class)responseDataClass
{
    return [RoomListRspData class];
}

- (BaseResponseData *)parseResponseData:(NSDictionary *)dataDic
{
    return [NSObject parse:[self responseDataClass] dictionary:dataDic itemClass:[TCShowLiveListItem class]];
}

@end

@implementation RoomListRspData

@end
