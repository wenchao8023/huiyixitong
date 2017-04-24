//
//  TabbarController.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/11/7.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "TabbarController.h"

#import "LiveListViewController.h"
#import "SettingViewController.h"
#import "PublishViewController.h"
#import "CSHomeViewController.h"

#import "UIImage+Common.h"

#import "CSCallCominglistener.h"

@interface TabbarController ()
{
    UIButton *_liveButton;
}
@end

@implementation TabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTabbar];
    
    [[TILCallManager sharedInstance] setIncomingCallListener:[[CSCallCominglistener alloc] init]];
}

- (void)initTabbar
{
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:kColorWhite size:self.tabBar.frame.size]];
    
    LiveListViewController *listVC = [[LiveListViewController alloc] init];
    UINavigationController *listNav = [[UINavigationController alloc] initWithRootViewController:listVC];
    
    PublishViewController *publishVC = [[PublishViewController alloc] init];
    UINavigationController *publishNav = [[UINavigationController alloc] initWithRootViewController:publishVC];
    
    SettingViewController *setVC = [[SettingViewController alloc] init];
    UINavigationController *setNav = [[UINavigationController alloc] initWithRootViewController:setVC];
    
    UIStoryboard *sbd = [UIStoryboard storyboardWithName:@"CSCall" bundle:nil];
    UINavigationController *callNav = sbd.instantiateInitialViewController;
    
    
    self.viewControllers = [NSArray arrayWithObjects:listNav, publishNav, callNav, setNav, nil];
    
    UITabBarItem *liveListItem = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *publishItem = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *callItem = [self.tabBar.items objectAtIndex:2];
    UITabBarItem *setItem = [self.tabBar.items objectAtIndex:3];
    
    
    [self setTabBarItem:liveListItem withNormalImageName:@"video" andSelectedImageName:@"video_hover" andTitle:@"最新"];
    [self setTabBarItem:publishItem withNormalImageName:@"video" andSelectedImageName:@"video_hover"  andTitle:@"直播"];
    [self setTabBarItem:callItem withNormalImageName:@"User" andSelectedImageName:@"User_hover" andTitle:@"视频"];
    [self setTabBarItem:setItem withNormalImageName:@"User" andSelectedImageName:@"User_hover" andTitle:@"设置"];
    
    
    //我来直播
//    _liveButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _liveButton.frame = CGRectMake(self.tabBar.frame.size.width/2-30, -15, 60, 60);
//    _liveButton.layer.cornerRadius = 30;
//    _liveButton.layer.borderWidth = 5;
//    _liveButton.layer.borderColor = kColorWhite.CGColor;
//    _liveButton.layer.masksToBounds = YES;
//    
//    [_liveButton setImage:[UIImage imageNamed:@"play_hover"] forState:UIControlStateNormal];
//    _liveButton.adjustsImageWhenHighlighted = NO;//去除按钮的按下效果（阴影）
//    [_liveButton addTarget:self action:@selector(onLiveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(_liveButton.superview != nil)
    {
        [_liveButton removeFromSuperview];
    }
    [self.tabBar addSubview:_liveButton];
}

- (void)onLiveButtonClicked
{
    PublishViewController *publishVC = [[PublishViewController alloc] init];
    [[AppDelegate sharedAppDelegate] pushViewController:publishVC];
}

- (void)setTabBarItem:(UITabBarItem *) tabBarItem withNormalImageName:(NSString *)normalImageName andSelectedImageName:(NSString *)selectedImageName andTitle:(NSString *)title
{
    [tabBarItem setImage:[[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setTitle:title];
}


@end
