//
//  UserContactViewController.m
//  M8Tool
//
//  Created by chao on 2017/5/22.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "UserContactViewController.h"

@interface UserContactViewController ()

@end

@implementation UserContactViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setHeaderTitle:[self getTitle]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - 判断视图类型
- (NSString *)getTitle {
    switch (self.contactType) {
        case ContactType_tel:
            return @"手机通话";
            break;
        case ContactType_contact:
            return @"通讯录";
            break;
        case ContactType_sel:
            return @"选择参会人员";
            break;
        default:
            return @"通讯录";
            break;
    }
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
