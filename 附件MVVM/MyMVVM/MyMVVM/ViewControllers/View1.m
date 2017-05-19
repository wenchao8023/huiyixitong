//
//  View1.m
//  MyMVVM
//
//  Created by chao on 2017/4/26.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "View1.h"
#import "Model1.h"
#import "ViewModel1.h"


@interface View1 ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end


@implementation View1


- (IBAction)testBtnClick:(id)sender {
    
    if (self.viewEventsBlock) {
        self.viewEventsBlock(@"btnClick");
    }
}
- (IBAction)jumpOtherVC:(id)sender {
    
    if (self.viewDelegate &&
        [self.viewDelegate respondsToSelector:@selector(smk_view:withEvents:)]) {
        [self.viewDelegate smk_view:self withEvents:@{@"jump" : @"vc"}];
    }
}


- (void)smk_configureViewWithViewModel:(id<SMKViewModelProtocol>)viewModel {

    [viewModel smk_viewModelWithModelBlcok:^(id model) {
        Model1 *model1 = (Model1 *)model;
        self.testLabel.text = model1.title;
    }];
    
    
}
@end
