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


-(void)onMultiCallInvitation:(TILCallInvitation *)invitation {
    
    UIViewController *nav = [[AppDelegate sharedAppDelegate] topViewController];
    NSLog(@"back form %@", NSStringFromClass([nav class]));
    CSCallComingViewController *call = [[UIStoryboard storyboardWithName:@"CSCall" bundle:nil] instantiateViewControllerWithIdentifier:@"CSCallComingViewController"];
    call.invitation = invitation;
    [nav presentViewController:call animated:YES completion:nil];
}

@end
