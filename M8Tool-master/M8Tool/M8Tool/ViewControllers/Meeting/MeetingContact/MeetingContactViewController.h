//
//  MeetingContactViewController.h
//  M8Tool
//
//  Created by chao on 2017/5/17.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "BaseViewController.h"

/**
 通讯录、手机通话界面
 */

typedef enum : NSInteger {
    
    ContactType_contact,
    ContactType_tel
    
}ContactType;


@interface MeetingContactViewController : BaseViewController

@property (nonatomic, assign) ContactType contactType;

@end
