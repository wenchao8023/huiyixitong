//
//  CSQuickBeginViewController.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/5.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSQuickBeginViewController.h"


@interface CSQuickBeginViewController ()

@end

@implementation CSQuickBeginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"MakeCall"]) {
//        
//        if (self.selectNumbers <= 0) {
//            return ;
//            
//        } else {
//            UIViewController *destinationController = [segue destinationViewController];
//            
//            if (self.selectNumbers == 1) {
//                [destinationController setValue:@102 forKey:@"_beginType"];
//                [destinationController setValue:@110 forKey:@"_callType"];
//                [destinationController setValue:[self.selectArray firstObject] forKey:@"peerid"];
//                
//            } else {
//                [destinationController setValue:@102 forKey:@"_beginType"];
//                [destinationController setValue:@111 forKey:@"_callType"];
//                [destinationController setValue:self.selectArray forKey:@"peerArray"];
//            }
//        }
//    }
//}


- (IBAction)callOfficephone:(id)sender {
}


- (IBAction)callVideophone:(id)sender {
    
}


- (IBAction)callNetphone:(id)sender {
    
}


- (IBAction)callTelephone:(id)sender {
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"15889444427"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"15889444427"];
//    //            NSLog(@"str======%@",str);
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
