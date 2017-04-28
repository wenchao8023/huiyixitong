//
//  DeviceView.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/28.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CallDeviceView.h"
#import "DeviceModel.h"

@interface CallDeviceView ()


/**
 通话人员数
 */
@property (weak, nonatomic) IBOutlet UIImageView *numberImg;

/**
 通话人员头像信息
 */
@property (weak, nonatomic) IBOutlet UIScrollView *iconScroll;

/**
 关闭摄像头
 */
@property (weak, nonatomic) IBOutlet UIButton *closeCameraButton;

/**
 切换麦克风
 */
@property (weak, nonatomic) IBOutlet UIButton *swichCameraButton;

/**
 关闭麦克风
 */
@property (weak, nonatomic) IBOutlet UIButton *closeMicButton;

/**
 免提
 */
@property (weak, nonatomic) IBOutlet UIButton *switchReceiverButton;



@end

@implementation CallDeviceView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


#pragma mark - 通话相关
// 邀请通话成员
- (IBAction)inviteMembers:(id)sender {
    [self sendEventsToManger:@{@"callControl" : @"inviteMembers"}];
}

#pragma mark - 设备操作
// 关闭摄像头
- (IBAction)closeCamera:(id)sender {
    [self sendEventsToManger:@{@"deviceControl" : @"closeCamera"}];
}
// 切换摄像头
- (IBAction)switchCamera:(id)sender {
    [self sendEventsToManger:@{@"deviceControl" : @"switchCamera"}];
}
// 关闭麦克风
- (IBAction)closeMic:(id)sender {
    [self sendEventsToManger:@{@"deviceControl" : @"closeMic"}];
}
// 免提（切换声音接收器）
- (IBAction)switchReceiver:(id)sender {
    [self sendEventsToManger:@{@"deviceControl" : @"switchReceiver"}];
}


#pragma mark - SMKViewModelProtocol
//- (void)smk_configureViewWithModel:(id)model {
//    
//    
//}
//
- (void)smk_configureViewWithViewModel:(id<SMKViewModelProtocol>)viewModel {
    
    [viewModel smk_viewModelWithModelBlcok:^(id model) {
        DeviceModel *deModel = (DeviceModel *)model;
        
        self.numberImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"number%d", (int)deModel.invite.memberArray.count]];
    }];
}


#pragma mark - private
#pragma mark -- 传递 view 上的事件
- (void)sendEventsToManger:(NSDictionary *)events {
    
    if (self.viewDelegate &&
        [self.viewDelegate respondsToSelector:@selector(smk_view:withEvents:)]) {
        [self.viewDelegate smk_view:self withEvents:events];
    }
}


@end
