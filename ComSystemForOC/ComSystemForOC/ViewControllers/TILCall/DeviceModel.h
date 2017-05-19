//
//  DeviceModel.h
//  ComSystemForOC
//
//  Created by chao on 2017/4/28.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject

@property (nonatomic, strong, nullable) TILCallInvitation *invite;

@property (nonatomic, assign) BOOL isCameraOn;

@property (nonatomic, assign) cameraPos cameraPoss;

@end
