//
//  AppDelegate.m
//  ComSystemForOC
//
//  Created by chao on 2017/3/27.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"

//#import <objc/runtime.h>

#define SDKAppID     1400025495
#define AccountType  11456

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (UIAlertController *)showAlert:(UIViewController *)rootVC title:(NSString *)title message:(NSString *)msg okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle ok:(ActionHandle)succ cancel:(ActionHandle)fail
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    if (cancelTitle)
    {
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:fail]];
    }
    if (okTitle)
    {
        [alert addAction:[UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:succ]];
    }
    [rootVC presentViewController:alert animated:YES completion:nil];
    return alert;
}

- (void)pushViewController:(UIViewController *)viewController
{
    @autoreleasepool
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [[self navigationViewController] pushViewController:viewController animated:YES];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    @autoreleasepool
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [[self navigationViewController] pushViewController:viewController animated:animated];
    }
}

- (UIViewController *)popViewController
{
    return [[self navigationViewController] popViewControllerAnimated:YES];
}

- (NSArray *)popToRootViewController
{
    return [[self navigationViewController] popToRootViewControllerAnimated:NO];
}

- (NSArray *)popToViewController:(UIViewController *)viewController
{
    return [[self navigationViewController] popToViewController:viewController animated:YES];
}

// 获取当前活动的navigationcontroller
- (UINavigationController *)navigationViewController
{
    UIWindow *window = self.window;
    
    if ([window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)window.rootViewController;
    }
    else if ([window.rootViewController isKindOfClass:[UITabBarController class]])
    {
        UIViewController *selectVc = [((UITabBarController *)window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)selectVc;
        }
    }
    
    return nil;
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self navigationViewController];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

//
//- (UIViewController *)currentViewController
//{
//    UIViewController *result;
//    
//    UIWindow *topWindow = [[[UIApplication sharedApplication] delegate] window];
//    
//    NSLog(@"%@",[[UIApplication sharedApplication] windows]);
//    if (topWindow.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(topWindow in windows)
//        {
//            if (topWindow.windowLevel == UIWindowLevelNormal)
//                break;
//        }
//    }
//    id lenderClass = objc_getClass("UILayoutContainerView"); // 通过字符串名字，获取类
//    
//    id nextResponder;
//    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
//    
//    if([[UIDevice currentDevice].systemVersion compare:@"8.0"]!= NSOrderedAscending &&
//       [rootView isMemberOfClass:[lenderClass class]])
//    {
//        NSArray *arr = [rootView valueForKey:@"subviewCache"];
//        if(arr.count>0)
//        {
//            UIView *v = [arr objectAtIndex:0];
//            nextResponder = [v nextResponder];
//        }
//        else
//        {
//            nextResponder = [[[rootView subviews] objectAtIndex:0] nextResponder];
//        }
//        
//    }
//    else
//    {
//        nextResponder = [rootView nextResponder];
//    }
//    
//    
//    if ([nextResponder isKindOfClass:[UIViewController class]])
//    {
//        result = nextResponder;
//    }
//    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
//    {
//        result = topWindow.rootViewController;
//    }
//    else
//    {
//        
//        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
//    }
//    
//    return result;
//}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#warning 这里需要注册并使用自己的Appkey
    //注册ShareSDK
    [ShareSDK registerApp:@"1ba4e87f44fec" activePlatforms:@[@(SSDKPlatformTypeWechat)] onImport:^(SSDKPlatformType platformType){
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            default:
                break;
        }
    }onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx588cac36c5d302f2" appSecret:@"f1c9fed7bd2745050bc05991d4b812e1"];
                break;
            default:
                break;
        }
    }];

    TIMManager *manager = [[ILiveSDK getInstance] getTIMManager];
    
    NSNumber *evn = [[NSUserDefaults standardUserDefaults] objectForKey:kEnvParam];
    [manager setEnv:[evn intValue]];
    
    NSNumber *logLevel = [[NSUserDefaults standardUserDefaults] objectForKey:kLogLevel];
    [manager initLogSettings:YES logPath:[manager getLogPath]];
    [manager setLogLevel:(TIMLogLevel)[logLevel integerValue]];
    
    [[ILiveSDK getInstance] initSdk:[ShowAppId intValue] accountType:[ShowAccountType intValue]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [self configAppearance];
    return YES;
}

- (void)configAppearance
{
    [[UINavigationBar appearance] setBarTintColor:kColorRed];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorWhite,NSFontAttributeName:kAppLargeTextFont}];
    [[UINavigationBar appearance] setTintColor:kColorWhite];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorWhite,NSFontAttributeName:kAppLargeTextFont} forState:UIControlStateNormal];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ComSystemForOC"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
