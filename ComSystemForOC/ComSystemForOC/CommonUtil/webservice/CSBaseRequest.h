//
//  CSBaseRequest.h
//  ComSystemForOC
//
//  Created by chao on 2017/4/6.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - CSRequestPageParamItem

@interface CSRequestPageParamItem : NSObject

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) BOOL canLoadMore;

- (NSDictionary *_Nonnull)serializeSelfPropertyToJsonObject;

@end


#pragma mark - CSBaseRequest

@class CSBaseRequest;
@class CSBaseResponse;
@class CSBaseResponseData;

typedef void(^CSRequestCompletionHandler)(CSBaseRequest  * _Nonnull request);

@interface CSBaseRequest : NSObject
{
@protected
    CSBaseRequest *_request;
    CSRequestCompletionHandler _succHandler;
    CSRequestCompletionHandler _failHandler;
}

@property (nonatomic, strong, nullable) CSBaseResponse *response;
@property (nonatomic, copy, nullable) CSRequestCompletionHandler succHandler;
@property (nonatomic, copy, nullable) CSRequestCompletionHandler failHandler;

- (instancetype _Nonnull )initWithHandler:(CSRequestCompletionHandler _Nonnull)succHandler;

- (instancetype _Nonnull )initWithHandler:(CSRequestCompletionHandler _Nonnull)succHandler failHandler:(CSRequestCompletionHandler _Nonnull)failHandler;

- (NSString * _Nonnull)url;

- (NSDictionary *)packageParams;

// 将 packageParams 拼装成Json请求包
- (NSData *)toPostJsonData;

// 收到响应后作解析响应处理
- (void)parseResponse:(NSObject *)respJsonObject;

// 配置_response对应的类
- (Class)responseClass;

- (Class)responseDataClass;

// 解析返回的字典结构json
- (void)parseDictionaryResponse:(NSDictionary *)bodyDic;
- (BaseResponseData *)parseResponseData:(NSDictionary *)dataDic;

// 解析返回的数组结构json
- (void)parseArrayResponse:(NSArray *)bodyArray;

@end


@interface CSBaseResponse : NSObject

// 对应json中返回的字段
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, copy) NSString *errorInfo;
@property (nonatomic, strong) BaseResponseData *data;

// 请求是否成功
- (BOOL)success;

// 请求失败时对应的提示语
- (NSString *)message;

@end

@interface CSBaseResponseData : NSObject

@end
