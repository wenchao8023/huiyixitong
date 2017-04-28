//
//  ViewController1.m
//  MyMVVM
//
//  Created by chao on 2017/4/26.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "ViewController1.h"
#import "ViewModel1.h"
#import "ViewManager1.h"
#import "View1.h"


@interface ViewController1 ()

@property (nonatomic, strong) ViewManager1  *viewManager;
@property (nonatomic, strong) ViewModel1    *viewModel;
@property (nonatomic, strong) View1         *view1;

@end

@implementation ViewController1

- (ViewManager1 *)viewManager {
    if (!_viewManager) {
        _viewManager = [[ViewManager1 alloc] init];
    }
    return _viewManager;
}

- (ViewModel1 *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ViewModel1 alloc] init];
    }
    return _viewModel;
}

- (View1 *)view1 {
    if (!_view1) {
        View1 *view1 = [View1 sui_loadInstanceFromNib];
        view1.frame = CGRectMake(0, 40, kScreenWidth, 200);
        [self.view addSubview:(_view1 = view1)];
    }
    return _view1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self cneterControl];
}

- (void)cneterControl {
    
    [self delegateControl];
    
//    [self blockControl];
//
//    [self mediatorControl];
    
    
}
#pragma mark -- delegate
- (void)delegateControl {
    
    // 将 view1 中的事件处理者代理交给 viewManger（代理方式）
    [self.view1 smk_viewWithViewManger:self.viewManager];
    
    // viewManger ----> info <---- viewModel 之间通过【代理】交互
    self.viewManager.viewMangerDelegate = self.viewModel;
    self.viewModel.viewModelDelegate = self.viewManager;
}

#pragma mark -- block
- (void)blockControl {
    
    // self.thirdView.viewEventsBlock（block方式）
    self.view1.viewEventsBlock = [self.viewManager smk_viewMangerWithViewEventBlockOfInfos:@{@"view" : self.view1}];
    
    // viewManger ----> info <---- viewModel 之间通过 block 交互
    self.viewManager.viewMangerInfosBlock = [self.viewModel smk_viewModelWithViewMangerBlockOfInfos:@{@"info" : @"viewManger"}];
}
#pragma mark -- mediator
- (void)mediatorControl {
    
    SMKMediator *mediator = [SMKMediator mediatorWithViewModel:self.viewModel viewManger:self.viewManager];
    
    self.viewManager.smk_mediator = mediator;
    self.viewModel.smk_mediator = mediator;
    
    self.viewManager.smk_viewMangerInfos = @{@"xxxxxx" : @"22222222"};
    [self.viewManager smk_notice];
    WCLog(@"viewManger ----> viewModel == %@", self.viewModel.smk_viewModelInfos);
    
    self.viewModel.smk_viewMangerInfos = @{@"oooooo" : @"888888888"};
    [self.viewModel smk_notice];
    WCLog(@"viewModel ----> viewManger == %@", self.viewManager.smk_viewMangerInfos);
}


- (IBAction)btnClick:(id)sender {
    
    // 根据 viewModel 配置 view
    [self.view1 smk_configureViewWithViewModel:self.viewModel];
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
