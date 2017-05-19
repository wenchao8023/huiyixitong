//
//  MakeCallViewController.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/28.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "MakeCallViewController.h"

#import "CallHeaderView.h"
#import "CallRenderView.h"
#import "CallDeviceView.h"

#import "HeaderViewManger.h"
#import "RenderViewManger.h"
#import "DeviceViewManger.h"


static  int kRenderViewHeight = 160;
static  int kRenderViewWidth  = 0;
static const int kRenderViewSpace = 10;


@interface MakeCallViewController ()

@property (nonatomic, strong) CallHeaderView *headerView;
@property (nonatomic, strong) CallRenderView *renderView;
@property (nonatomic, strong) CallDeviceView *deviceView;

@property (nonatomic, strong) HeaderViewManger *headerViewManger;
@property (nonatomic, strong) RenderViewManger *renderViewManger;
@property (nonatomic, strong) DeviceViewManger *deviceViewManger;



@end

@implementation MakeCallViewController

#pragma mark - 懒加载
#pragma mark -- 加载 views
- (CallHeaderView *)headerView {
    if (!_headerView) {
        CallHeaderView *headerView = [CallHeaderView sui_loadInstanceFromNib];
        headerView.frame = CGRectMake(0,
                                      0,
                                      kScreenWidth,
                                      kNaviHeight);
        [self.view addSubview:(_headerView = headerView)];
    }
    
    return _headerView;
}

- (CallRenderView *)renderView {
    if (!_renderView) {
        CallRenderView *renderView = [[CallRenderView alloc] init];
        renderView.frame = CGRectMake(kRenderViewSpace,
                                      kNaviHeight + kRenderViewSpace,
                                      WIDTH - 2 * kRenderViewSpace,
                                      kRenderViewHeight);
        [self.view addSubview:(_renderView = renderView)];
    }
    
    return _renderView;
}

- (CallDeviceView *)deviceView {
    if (!_deviceView) {
        CallDeviceView *deviceView = [CallDeviceView sui_loadInstanceFromNib];
        deviceView.frame = CGRectMake(0,
                                      CGRectGetMaxY(self.renderView.frame),
                                      kScreenWidth,
                                      kScreenHeight - CGRectGetMaxY(self.renderView.frame));
        [self.view addSubview:(_deviceView = deviceView)];
    }
    
    return _deviceView;
}

#pragma mark -- 加载 viewMangers
- (HeaderViewManger *)headerViewManger {
    if (!_headerViewManger) {
        _headerViewManger = [[HeaderViewManger alloc] init];
    }
    return _headerViewManger;
}

- (RenderViewManger *)renderViewManger {
    if (!_renderViewManger) {
        _renderViewManger = [[RenderViewManger alloc] init];
    }
    return _renderViewManger;
}

- (DeviceViewManger *)deviceViewManger {
    if (!_deviceViewManger) {
        _deviceViewManger = [[DeviceViewManger alloc] init];
    }
    return _deviceViewManger;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (iPhone5SE) {
        kRenderViewHeight = 120;
        kRenderViewWidth = kRenderViewHeight * 3 / 4;
    }
    else {
        kRenderViewHeight = 160;
        kRenderViewWidth = kRenderViewHeight * 3 / 4;
    }
    
    [self headerView];
    [self renderView];
    [self deviceView];
    
    [self.deviceView smk_viewWithViewManger:self.deviceViewManger];
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
