//
//  ViewManager1.m
//  MyMVVM
//
//  Created by chao on 2017/4/26.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "ViewManager1.h"
#import "ViewController2.h"

@implementation ViewManager1

#pragma mark UIView 的 delegate 方法
- (void)smk_view:(__kindof UIView *)view withEvents:(NSDictionary *)events {
    
    WCLog(@"%@", events);
    if ([[events allKeys] containsObject:@"jump"]) {
        ViewController2 *vc = [UIViewController sui_viewControllerWithStoryboard:@"Main" identifier:@"ViewController2"];
        [view.sui_currentVC.navigationController pushViewController:vc animated:YES];
    }
}

//#pragma mark ViewEvents Block
//- (ViewEventsBlock)smk_viewMangerWithViewEventBlockOfInfos:(NSDictionary *)infos {
//    
//    return ^{
//      
//        if (self.viewMangerInfosBlock) {
//            self.viewMangerInfosBlock();
//        }
//        
//        if (self.viewMangerDelegate &&
//            [self.viewMangerDelegate respondsToSelector:@selector(smk_viewManger:withInfos:)]) {
//            
//            [self.viewMangerDelegate smk_viewManger:self withInfos:@{@"info" : @"你好ViewModel，我是viewManger，我被点击了"}];
//        }
//    };
//}

#pragma mark ViewModel Delegate
- (void)smk_viewModel:(id)viewModel withInfos:(NSDictionary *)infos {
    WCLog(@"%@", infos);
}

//#pragma makr 中介者传值
//- (void)smk_notice {
//    [self.smk_mediator noticeViewModelWithInfos:self.smk_viewMangerInfos];
//}
@end
