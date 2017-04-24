//
//  CSBaseRequest.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/6.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSBaseRequest.h"

#import "NSObject+Json.h"






@implementation CSRequestPageParamItem

- (instancetype)init {
    
    if (self = [super init]) {
        
        _pageIndex = 0;
        _pageSize = 20;
        _canLoadMore =YES;
    }
    
    return self;
}

- (NSDictionary *)serializeSelfPropertyToJsonObject {
    
    return @{@"pageIndex" : @(_pageIndex),
             @"pageSize" : @(_pageSize)};
}

@end






@implementation CSBaseRequest

- (void)dealloc {
    
    NSLog(@"==========%@ release succece>>>>>>>>", NSStringFromClass([self class]));
}

- (instancetype)initWithHandler:(CSRequestCompletionHandler)succHandler {
    
    if (self = [super init]) {
        
        self.succHandler = succHandler;
    }
    
    return self;
}

- (instancetype)initWithHandler:(CSRequestCompletionHandler)succHandler failHandler:(CSRequestCompletionHandler)failHandler {
    
    if (self = [self initWithHandler:succHandler]) {
        
        self.failHandler = failHandler;
    }
    
    return self;
}

- (NSString *)url {
    
    return nil;
}

-(CSBaseResponse *)response {
    
    if (!_response) {
        
        _response = [[[self responseClass] alloc] init];
    }
    
    return _response;
}

-(NSDictionary *)packageParams {
    
    return nil;
}

-(NSData *)toPostJsonData {
    
    NSDictionary *dic = [self packageParams];
    //转成 json 数据
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
        if (error) {
            NSLog(@"[%@] Post Json Error: %@", [self class], dic);
            
        } else {
            NSLog(@"[%@] Post Json : %@", [self class], dic);
        }
        
        return data;
        
    } else {
        NSLog(@"[%@] Post Json is not valid: %@", [self class], dic);
    }
    
    return nil;
}

-(void)parseResponse:(NSObject *)respJsonObject {
    
    if (respJsonObject) {
         NSLog(@"==========[%@]开始解析响应>>>>>>>>>", self);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 子线程解析数据
            if (_succHandler) {
                
                // todo handle body
                if ([respJsonObject isKindOfClass:[NSDictionary class]]) {
                    [self parseDictionaryResponse:(NSDictionary *)respJsonObject];
                    
                } else if ([respJsonObject isKindOfClass:[NSArray class]]) {
                    [self parseArrayResponse:(NSArray *)respJsonObject];
                    
                } else {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSLog(@"返回数据格式有误");
                        // 说明返回内容有问题
                        if (_failHandler)
                        {
                            _failHandler(self);
                        }
                        NSLog(@"==========[%@]开始解析响应完成>>>>>>>>>", self);
                    });
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([_response success])
                        {
                            if (_succHandler)
                            {
                                _succHandler(self);
                                
                            }
                        }
                        else
                        {
                            NSLog(@"%@", [_response message]);
                            // 返回的数据有业务错误
                            if (_failHandler)
                            {
                                _failHandler(self);
                            }
                        }
                        NSLog(@"==========[%@]开始解析响应完成>>>>>>>>>", self);
                    });
                }
            }
        });
    }
    else
    {
        NSLog(@"[%@]返回数据为空", [self class]);
        dispatch_async(dispatch_get_main_queue(), ^{
            // 说明返回内容有问题
            if (_failHandler)
            {
                _failHandler(self);
            }
        });
    }
}


- (Class)responseClass {
    return [CSBaseResponse class];
}

- (Class)responseDataClass {
    return [CSBaseResponseData class];
}

- (void)parseDictionaryResponse:(NSDictionary *)bodyDic {
    
    _response = [[[self responseDataClass] alloc] init];
    _response.errorCode = [bodyDic[@"errorCode"] integerValue];
    _response.errorInfo = bodyDic[@"errorInfo"];
    
    NSDictionary *dataDic = bodyDic[@"data"];
    _response.data = [self parseResponseData:dataDic];
}

- (BaseResponseData *)parseResponseData:(NSDictionary *)dataDic {
    return [NSObject parse:[self responseDataClass] dictionary:dataDic];
}

- (void)parseArrayResponse:(NSArray *)bodyArray {
    
}

@end








@implementation CSBaseResponseData

@end








@implementation CSBaseResponse

- (instancetype)init {
    
    if (self = [super init]) {
        // 默认成功
        _errorCode = 0;
    }
    
    return self;
}

- (BOOL)success {
    
    return _errorCode == 0;
}

- (NSString *)message {
    
    return _errorInfo;
}

@end


