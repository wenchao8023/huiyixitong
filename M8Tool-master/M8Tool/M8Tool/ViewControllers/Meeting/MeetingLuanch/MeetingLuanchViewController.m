//
//  MeetingLuanchViewController.m
//  M8Tool
//
//  Created by chao on 2017/5/17.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "MeetingLuanchViewController.h"
#import "MeetingLuanchTableView.h"

@interface MeetingLuanchViewController ()

@property (nonatomic, strong) MeetingLuanchTableView *tableView;

@end

@implementation MeetingLuanchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setHeaderTitle:[self getTitle]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)createUI {
    // 重新设置 contentView 的高度
    [self.contentView setHeight:kContentHeight_bottom30];
    // 添加 tableView
    [self tableView];
    // 添加 发起按钮
    [self luanchButton];
}

- (MeetingLuanchTableView *)tableView {
    if (!_tableView) {
        MeetingLuanchTableView *tableView = [[MeetingLuanchTableView alloc] initWithFrame:self.contentView.bounds];
        tableView.height -= 60;
        [self.contentView addSubview:(_tableView = tableView)];
    }
    return _tableView;
}

- (void)luanchButton {
    UIButton *luanchButton = [WCUIKitControl createButtonWithFrame:CGRectMake(kMarginView_horizontal, self.contentView.height - 60, self.contentView.width - 2 * kMarginView_horizontal, 50)
                                                            Target:self
                                                            Action:@selector(luanchMeetingAction)
                                                             Title:@"立即发起"];
    [luanchButton setAttributedTitle:[CommonUtil customAttString:luanchButton.titleLabel.text
                                                        fontSize:kAppNaviFontSize
                                                       textColor:WCWhite
                                                       charSpace:kAppKern_2]
                            forState:UIControlStateNormal];
    WCViewBorder_Radius(luanchButton, 25);
    [luanchButton setBackgroundColor:WCButtonColor];
    [self.contentView addSubview:luanchButton];
}

- (void)luanchMeetingAction {
    WCLog(@"立即发起<!--%@--!>", [[self getTitle] substringFromIndex:1]);
}

#pragma mark - 判断视图类型
- (NSString *)getTitle {
    switch (self.luanchMeetingType) {
        case LuanchMeetingType_phone:
            return @"创建电话会议";
            break;
        case LuanchMeetingType_video:
            return @"创建视频会议";
            break;
        case LuanchMeetingType_audio:
            return @"创建云直播会议";
            break;
        default:
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
