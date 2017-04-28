//
//  RegistRequest.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/11/30.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "RegistRequest.h"

#import "NSObject+Json.h"

@implementation RegistRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=account&cmd=regist";
}

- (NSDictionary *)packageParams
{
    NSDictionary *paramDic = @{@"uname"  : _identifier,
                               @"pwd" : _pwd
                               };
    return paramDic;
}

//- (void)setIdPropertyValue:(id)idkeyValue
//{
//    NSNumber *value =  (NSNumber *)idkeyValue;
//    _identifier = [value integerValue];
//}


@end

