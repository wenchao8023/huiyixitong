//
//  CSCallCominglistener.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/8.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSCallCominglistener.h"

#import "CSCallComingViewController.h"



@implementation CSCallCominglistener



-(void)onC2CCallInvitation:(TILCallInvitation *)invitation {
    
    [self presentViewControllerWithCallType:CSCallComing_C2C];
    
}

-(void)onMultiCallInvitation:(TILCallInvitation *)invitation {
    
    [self presentViewControllerWithCallType:CSCallComing_mult];
}

-(void)presentViewControllerWithCallType:(CSCallComingType)type {
   
//    UINavigationController *nav = [[AppDelegate sharedAppDelegate] navigationViewController];
//    CSCallComingViewController *call = [[UIStoryboard storyboardWithName:@"CSCall" bundle:nil] instantiateViewControllerWithIdentifier:@"CSCallComingViewController"];
//    call.callComingType = type;
//    [nav presentViewController:call animated:YES completion:nil];
    
    UIViewController *nav = [[AppDelegate sharedAppDelegate] topViewController];
    NSLog(@"back form %@", NSStringFromClass([nav class]));
    CSCallComingViewController *call = [[UIStoryboard storyboardWithName:@"CSCall" bundle:nil] instantiateViewControllerWithIdentifier:@"CSCallComingViewController"];
    call.callComingType = type;
    [nav presentViewController:call animated:YES completion:nil];
}
@end
