//
//  CSMakeCallViewController.h
//  ComSystemForOC
//
//  Created by chao on 2017/4/7.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSInteger {
    
    CSBegin_quickBegin = 100,
    CSBegin_orderBegin,
    CSBegin_friendsBegin
    
}CSBeginType;

typedef enum : NSInteger {
    
    CSCall_c2c = 110,
    CSCall_mult
    
}CSCallType;


@interface CSMakeCallViewController : UIViewController
{
    CSBeginType _beginType;
    CSCallType _callType;
}

@property (nonatomic, copy, nullable) NSString *peerId;

@property (nonatomic, strong, nullable) NSArray *peerArray;


@end
