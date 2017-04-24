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


- (IBAction)rejectCall:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)unwindForBack:(UIStoryboardSegue *)segue {
    
    
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
