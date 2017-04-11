//
//  LiveImageSignRequest.m
//  TCShow
//
//  Created by AlexiChen on 16/5/3.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "LiveImageSignRequest.h"

@implementation LiveImageSignRequest

- (NSString *)url
{
    return @"http://139.199.208.191/SuiXinBoPHPServer-StandaloneAuth/index.php?svc=cos&cmd=get_sign";
}

- (Class)responseDataClass
{
    return [LiveImageSignResponseData class];
}

@end

@implementation LiveImageSignResponseData

@end
