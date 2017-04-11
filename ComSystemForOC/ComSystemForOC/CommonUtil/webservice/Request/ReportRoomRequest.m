//
//  ReportRoomRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/8.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "ReportRoomRequest.h"

#import "NSMutableDictionary+Json.h"
#import "NSObject+Json.h"

@implementation ReportRoomRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=live&cmd=reportroom";
}

- (NSDictionary *)packageParams
{
    NSDictionary *dic = @{ @"token" : _token,
                           @"room"  : [_room toRoomDic],
                        };
    //@"lbs"   : [_lbs toLBSDic]
    return dic;
}
@end


