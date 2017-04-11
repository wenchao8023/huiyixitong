//
//  CSCallComingViewController.h
//  ComSystemForOC
//
//  Created by chao on 2017/4/8.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    
    CSCallComing_C2C = 120,
    CSCallComing_mult
    
}CSCallComingType;

@interface CSCallComingViewController : UIViewController

@property (nonatomic, assign) CSCallComingType callComingType;


@end
