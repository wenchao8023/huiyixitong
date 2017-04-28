//
//  CSCallComingViewController.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/8.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSCallComingViewController.h"

#import "CSRecvViewController.h"

@interface CSCallComingViewController ()

@end

@implementation CSCallComingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)receiveCall:(id)sender {
    
    CSRecvViewController *recvVC = [[UIStoryboard storyboardWithName:@"CSCall" bundle:nil] instantiateViewControllerWithIdentifier:@"CSRecvViewController"];
    recvVC.invite = self.invite;
    [self addChildViewController:recvVC];
    
    recvVC.view.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:recvVC.view];
    
}

- (IBAction)rejectCall:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)unwindForBack:(UIStoryboardSegue *)segue {
    
    
}



- (void)changeControllerFromOldController:(UIViewController *)oldController toNewController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    /**
     *  切换ViewController
     */
    [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        //做一些动画
        
    } completion:^(BOOL finished) {
        
//        if (finished) {
//            
//            //移除oldController，但在removeFromParentViewController：方法前不会调用willMoveToParentViewController:nil 方法，所以需要显示调用
//            [self didMoveToParentViewController:newController];
//            [oldController willMoveToParentViewController:nil];
//            [oldController removeFromParentViewController];
//            currentVC = newController;
//            
//        }else
//        {
//            currentVC = oldController;
//        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
