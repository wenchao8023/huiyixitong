//
//  DeviceViewManger.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/28.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "DeviceViewManger.h"

@implementation DeviceViewManger

/**
 *  将view中的事件通过代理传递出去
 *
 *  @param view   view自己
 *  @param events 所触发事件的一些描述信息
 */
- (void)smk_view:(__kindof UIView *)view withEvents:(NSDictionary *)events {
    WCLog(@"%@", events);
    
    if ([[events allKeys] containsObject:@"callControl"]) {
        NSString *methodStr = events[@"callControl"];
        if ([methodStr isEqualToString:@"inviteMembers"]) {
            [self inviteMembers];
        }
    }
    
    if ([[events allKeys] containsObject:@"deviceControl"]) {
        NSString *methodStr = events[@"deviceControl"];
        if ([methodStr isEqualToString:@"closeCamera"]) {
            [self closeCamera];
        }
        
        if ([methodStr isEqualToString:@"switchCamera"]) {
            [self switchCamera];
        }
        
        if ([methodStr isEqualToString:@"closeMic"]) {
            [self closeMic];
        }
        
        if ([methodStr isEqualToString:@"switchReceiver"]) {
            [self switchReceiver];
        }
    }
}

#pragma mark - 通话相关
// 邀请通话成员
- (void)inviteMembers {
    
}

#pragma mark - 设备操作
// 关闭摄像头
- (void)closeCamera {
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    BOOL isOn = [manager getCurCameraState];
    cameraPos pos = [manager getCurCameraPos];
    WCWeakSelf(self);
    [manager enableCamera:pos enable:!isOn succ:^{
        [weakself sendDataToViewModel:@{@"isCameraOn" : [NSNumber numberWithBool:!isOn]}];
    } failed:nil];
}
// 切换摄像头
- (void)switchCamera {
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    int pos = [manager getCurCameraPos];
    
    if (pos == -1) {
        WCLog(@"摄像头没有打开");
    }
    else {
        WCWeakSelf(self);
        [manager switchCamera:^{
            [weakself sendDataToViewModel:@{@"DeviceModel" : [NSNumber numberWithInt:!pos]}];
        } failed:^(NSString *module, int errId, NSString *errMsg) {
            WCLog(@"摄像头切换失败");
        }];
    }
}
// 关闭麦克风
- (void)closeMic {
    
}
// 免提（切换声音接收器）
- (void)switchReceiver {
    
}

#pragma mark - private
// 只传递数据过去，由 viewModel 将数据封装成 model
- (void)sendDataToViewModel:(NSDictionary *)infos {
    if (self.viewMangerDelegate &&
        [self.viewMangerDelegate respondsToSelector:@selector(smk_viewManger:withInfos:)]) {
        
        [self.viewMangerDelegate smk_viewManger:self withInfos:infos];
    }
    
}


@end
