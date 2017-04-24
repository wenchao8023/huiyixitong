//
//  AppDelegate.h
//  ComSystemForOC
//
//  Created by chao on 2017/3/27.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) NSString *token;

+ (instancetype)sharedAppDelegate;

+ (UIAlertController *)showAlert:(UIViewController *)rootVC title:(NSString *)title message:(NSString *)msg okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle ok:(ActionHandle)succ cancel:(ActionHandle)fail;

- (UINavigationController *)navigationViewController;
- (UIViewController *)topViewController;
- (UIViewController *)currentViewController;
- (NSArray *)popToRootViewController;
- (UIViewController *)popViewController;
- (NSArray *)popToViewController:(UIViewController *)viewController;
- (void)pushViewController:(UIViewController *)viewController;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

