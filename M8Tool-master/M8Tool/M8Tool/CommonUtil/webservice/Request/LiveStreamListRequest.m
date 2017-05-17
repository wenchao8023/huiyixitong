//
//  LiveStreamListRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/29.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "LiveStreamListRequest.h"

@implementation LiveStreamListRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=live&cmd=livestreamlist";
}

- (NSDictionary *)packageParams
{
    NSDictionary *dic = @{@"token" : _token,
                          @"index" : [NSNumber numberWithInteger:_index],
                          @"size" : [NSNumber numberWithInteger:_size],
                          };
    return dic;
}

- (Class)responseDataClass
{
    return [LiveStreamListRspData class];
}

- (BaseResponseData *)parseResponseData:(NSDictionary *)dataDic
{
    return [NSObject parse:[self responseDataClass] dictionary:dataDic itemClass:[LiveStreamListItem class]];
}

@end

@implementation LiveStreamListRspData

@end
