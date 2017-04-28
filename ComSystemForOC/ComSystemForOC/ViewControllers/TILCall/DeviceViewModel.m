//
//  DeviceViewModel.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/28.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "DeviceViewModel.h"
#import "DeviceModel.h"

@implementation DeviceViewModel

#pragma mark 加载网络请求
//- (NSURLSessionTask *)smk_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
//    return nil;
//}

- (void)smk_viewModelWithModelBlcok:(void (^)(id))modelBlock {
    
}

#pragma mark - private
- (void)sendModelToViewManger:(id)target Infos:(NSDictionary *)infos {
    if (self.viewModelDelegate &&
        [self.viewModelDelegate respondsToSelector:@selector(smk_viewModel:withInfos:)]) {
        
        [self.viewModelDelegate smk_viewModel:target withInfos:infos];
    }
}

@end
