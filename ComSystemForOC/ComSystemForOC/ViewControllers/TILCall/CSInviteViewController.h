//
//  CSInviteViewController.h
//  ComSystemForOC
//
//  Created by 郭文超 on 2017/4/21.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InviteBlock)(NSArray * _Nullable selectArray);

@interface CSInviteViewController : UIViewController

@property (nonatomic, strong, nullable) NSMutableArray *inviteMoreArray;

@property (nonatomic, copy, nullable) InviteBlock inviteBlock;

@end
