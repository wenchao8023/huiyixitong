//
//  ViewModel1.m
//  MyMVVM
//
//  Created by chao on 2017/4/26.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "ViewModel1.h"
#import "Model1.h"
#import "Request1.h"



@implementation ViewModel1

#pragma mark 加载网络请求
- (NSURLSessionTask *)smk_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    return [[SMKAction sharedAction] sendRequestBlock:^id(NSObject *request) {
        return [[Request1 alloc] init];
    } progress:nil success:^(id responseObject) {
        NSArray *modelArray = [Model1 mj_objectArrayWithKeyValuesArray:responseObject];
        if (success) {
            success(modelArray);
        }
    } failure:nil];
}

- (id)getRandomData:(NSArray *)array {
    u_int32_t index = arc4random_uniform((u_int32_t)10);
    return array[index];
}


#pragma mark 配置加工模型数据，并通过block传递给View
- (void)smk_viewModelWithModelBlcok:(void (^)(id))modelBlock {
//    [self smk_viewModelWithProgress:nil success:^(id responseObject) {
//        if (modelBlock) {
//            
//            if (self.viewModelDelegate &&
//                [self.viewModelDelegate respondsToSelector:@selector(smk_viewModel:withInfos:)]) {
//                
//                [self.viewModelDelegate smk_viewModel:self withInfos:@{@"info" : @"你好， 我是ViewModel，我加载数据成功了"}];
//            }
//            
////            modelBlock([self getRandomData:responseObject]);
//        }
//    } failure:nil];
    
    
    
    
//    使用代理将数据传给 viewManger
    if (self.viewModelDelegate &&
        [self.viewModelDelegate respondsToSelector:@selector(smk_viewModel:withInfos:)]) {
        
        [self.viewModelDelegate smk_viewModel:self withInfos:@{@"info" : @"你好， 我是ViewModel，我加载数据成功了"}];
    }
    
//    使用 block 将数据传给 view
    Model1 *model1 = [[Model1 alloc] init];
    model1.title = @"viewModel ====> viewManger";
    modelBlock(model1);
    
}


#pragma mark ViewManager Delegate
- (void)smk_viewManger:(id)viewManger withInfos:(NSDictionary *)infos {
    WCLog(@"%@", infos);
}
//
//#pragma mark ViewManager Block
//- (ViewMangerInfosBlock)smk_viewMangerWithViewModelBlockOfInfos:(NSDictionary *)infos {
//    return ^{
//        WCLog(@"hello");
//    };
//}
//
//#pragma mark 中介者传值
//- (void)smk_notice {
//    [self.smk_mediator noticeViewMangerWithInfos:self.smk_viewModelInfos];
//}

@end
