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



@interface CSMakeCallViewController : UIViewController
{
    CSBeginType _beginType;
}

//@property (nonatomic, copy, nullable) NSString *peerId;

@property (nonatomic, strong, nullable) NSArray *peerArray;


@end
