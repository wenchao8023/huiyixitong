//
//  RoomMemListRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/13.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "RoomMemListRequest.h"

@implementation RoomMemListRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=live&cmd=roomidlist";

}

- (NSDictionary *)packageParams
{
    NSDictionary *dic = @{@"token" : _token,
                          @"roomnum" : [NSNumber numberWithInteger:_roomnum],
                          @"index" : [NSNumber numberWithInteger:_index],
                          @"size" : [NSNumber numberWithInteger:_size],
                          };
    return dic;
}

- (Class)responseDataClass
{
    return [RoomMemListRspData class];
}

- (BaseResponseData *)parseResponseData:(NSDictionary *)dataDic
{
    return [NSObject parse:[self responseDataClass] dictionary:dataDic itemClass:[MemberListItem class]];
}

@end

@implementation RoomMemListRspData

@end
