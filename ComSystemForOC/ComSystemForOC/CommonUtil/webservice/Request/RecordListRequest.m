//
//  RecordListRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/12/12.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "RecordListRequest.h"

@implementation RecordListRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=live&cmd=recordlist";
//    return @"http://182.254.234.225/sxb_test/index.php?svc=live&cmd=recordlist";
}

- (NSDictionary *)packageParams
{
    NSDictionary *dic = @{@"token" : _token,
                          @"type" : [NSNumber numberWithInteger:_type],
                          @"index" : [NSNumber numberWithInteger:_index],
                          @"size" : [NSNumber numberWithInteger:_size]
                        };
    return dic;
}

//- (Class)responseClass
//{
//    return [RecordListResponese class];
//}
//- (Class)responseDataClass
//{
//    return [RecordListRspData class];
//}

- (void)parseDictionaryResponse:(NSDictionary *)bodyDic
{
    
    NSDictionary *dataDic = [bodyDic objectForKey:@"data"];
    int total = 0;
    id totalObj = [dataDic objectForKey:@"total"];
    if ([totalObj isKindOfClass:[NSString class]])
    {
        total = [totalObj intValue];
    }
    NSArray *videos = [dataDic objectForKey:@"videos"];
    
    NSMutableArray *parseVideos = [NSMutableArray array];
    for (NSDictionary *itemDic in videos)
    {
        RecordVideoItem *item = [[RecordVideoItem alloc] init];//= [NSObject parse:[RecordVideoItem class] dictionary:itemDic];// itemClass:[NSString class]
        item.uid = [itemDic objectForKey:@"uid"];
        item.name = [itemDic objectForKey:@"name"];
        item.cover = [itemDic objectForKey:@"cover"];
        item.videoId = [itemDic objectForKey:@"videoId"];
        item.playurl = [itemDic objectForKey:@"playurl"];
        
        [parseVideos addObject:item];
    }
    
    RecordListResponese *response = [[RecordListResponese alloc] init];
    response.errorCode = [[bodyDic objectForKey:@"code"] intValue];
    response.errorInfo = [bodyDic objectForKey:@"message"];
    response.total = total;
    response.videos = parseVideos;
    
    _response = response;
}

@end

@implementation RecordListResponese
@end

//@implementation RecordListRspData
//
//@end
