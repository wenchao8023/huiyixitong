//
//  RecordReportRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/12.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "RecordReportRequest.h"

@implementation RecordReportRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=live&cmd=reportrecord";
}

- (NSDictionary *)packageParams
{
    NSDictionary *dic = @{@"token" : _token,
                          @"roomnum" : [NSNumber numberWithInteger:_roomnum],
                          @"uid" : _uid,
                          @"name" : _name,
                          @"type" : [NSNumber numberWithInteger:_type],
                          @"cover":_cover,
                          };
    return dic;
}
@end
