//
//  CSRecvViewController.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/8.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSRecvViewController.h"
#import "CSInviteViewController.h"

static  int kRenderViewHeight = 160;
static  int kRenderViewWidth  = 0;
static const int kRenderViewSpace = 10;

@interface CSRecvViewController ()<TILCallNotificationListener,TILCallStatusListener, TILCallMemberEventListener>

@property (nonatomic, strong) TILMultiCall *call;

@property (nonatomic, strong) NSString *myId;

/**
 缩小
 */
@property (weak, nonatomic) IBOutlet UIButton *switchRenderButton;


/**
 通话时长
 */
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property (weak, nonatomic) IBOutlet UIView *btnsView;

/**
 关闭摄像头
 */
@property (weak, nonatomic) IBOutlet UIButton *closeCameraButton;

/**
 切换麦克风
 */
@property (weak, nonatomic) IBOutlet UIButton *swichCameraButton;

/**
 关闭麦克风
 */
@property (weak, nonatomic) IBOutlet UIButton *closeMicButton;

/**
 免提
 */
@property (weak, nonatomic) IBOutlet UIButton *switchReceiverButton;

/**
 取消
 */
@property (weak, nonatomic) IBOutlet UIButton *cancelInviteButton;

/**
 挂断
 */
//@property (weak, nonatomic) IBOutlet UIButton *hungUpButton;
@property (weak, nonatomic) IBOutlet UIButton *endComButton;

@property (weak, nonatomic) IBOutlet UILabel *inviterLabel;
@property (weak, nonatomic) IBOutlet UILabel *comDurationLabel;

@property (weak, nonatomic) IBOutlet UIButton *numberButton;
@property (weak, nonatomic) IBOutlet UIScrollView *memberScroll;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;


@property (nonatomic, strong, nonnull) UIScrollView *renderScroll;


@property (nonatomic, strong, nonnull) NSMutableArray *membersArray;    //记录房间通话的成员
@property (nonatomic, strong) NSMutableArray *indexArray;               //记录房间中开启视频的成员
@property (nonatomic, strong, nonnull) NSMutableArray *statuArray;      //记录房间中视频流处在背景视图的成员


@property (nonatomic, assign) int duration;
@property (nonatomic, strong, nullable) NSTimer *durationTimer;

@end

@implementation CSRecvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.view.bounds.size.height < 1000) {
        kRenderViewHeight = 120;
        kRenderViewWidth = kRenderViewHeight * 3 / 4;
    }
    else {
        kRenderViewHeight = 160;
        kRenderViewWidth = kRenderViewHeight * 3 / 4;
    }
    
    self.topSpace.constant = kRenderViewHeight + 2 * kRenderViewSpace;
    
    _membersArray = [NSMutableArray arrayWithCapacity:0];
    
    _indexArray = [[NSMutableArray alloc] init];
    
    _statuArray = [[NSMutableArray alloc] init];
    
//    [self setEnableButton:NO];
    self.cancelInviteButton.hidden = YES;
    self.btnsView.hidden = NO;
    
    [self.view addSubview:self.renderScroll];
    [self.view sendSubviewToBack:self.renderScroll];
    
    
    [self initCall];
    _myId = [[ILiveLoginManager getInstance] getLoginId];
}

- (UIScrollView *)renderScroll {
    
    if (!_renderScroll) {
        _renderScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(kRenderViewSpace,
                                                                       kNaviHeight + kRenderViewSpace,
                                                                       WIDTH - 2 * kRenderViewSpace,
                                                                       kRenderViewHeight)
                         ];
    }
    
    return _renderScroll;
}

#pragma mark - 通话接口相关
- (void)initCall{
    TILCallConfig * config = [[TILCallConfig alloc] init];
    TILCallBaseConfig * baseConfig = [[TILCallBaseConfig alloc] init];
    baseConfig.callType = TILCALL_TYPE_VIDEO;
    baseConfig.isSponsor = NO;
    baseConfig.memberArray = _invite.memberArray;
    baseConfig.heartBeatInterval = 15;
    config.baseConfig = baseConfig;
    
    TILCallListener * listener = [[TILCallListener alloc] init];
    listener.memberEventListener = self;
    listener.notifListener = self;
    config.callListener = listener;
    
    TILCallResponderConfig * responderConfig = [[TILCallResponderConfig alloc] init];
    responderConfig.callInvitation = _invite;
    config.responderConfig = responderConfig;
    _call = [[TILMultiCall alloc] initWithConfig:config];
    
    __weak typeof(self) ws = self;
    [_call createRenderViewIn:self.view];
    [_call accept:^(TILCallError *err) {
        if(err){
            [ws setText:[NSString stringWithFormat:@"接受失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
            [ws selfDismiss];
        }
        else{
            [ws setText:@"接受成功"];
            [[ILiveRoomManager getInstance] setBeauty:5];
            [[ILiveRoomManager getInstance] setWhite:5];
        }
        
        
    }];
}

- (IBAction)hangUp:(id)sender {
    
    __weak typeof(self) ws = self;
    [_call hangup:^(TILCallError *err) {
        if(err){
            [ws setText:[NSString stringWithFormat:@"挂断失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
        }
        else{
            [ws setText:@"挂断成功"];
        }
        [ws selfDismiss];
    }];
}

// 取消所有通话
- (IBAction)cancelInvite:(id)sender {
    
    __weak typeof(self) ws = self;
    
    [_call cancelAllCall:^(TILCallError *err) {
        if (err) {
            [ws setText:[NSString stringWithFormat:@"取消通话邀请失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
        }
        else {
            NSLog(@"取消通话邀请成功");
        }
        [ws selfDismiss];
    }];
}

#pragma mark - 设备操作（使用ILiveRoomManager接口，也可以使用TILCallSDK接口）
- (IBAction)closeCamera:(id)sender {
    
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    BOOL isOn = [manager getCurCameraState];
    cameraPos pos = [manager getCurCameraPos];
    __weak typeof(self) ws = self;
    [manager enableCamera:pos enable:!isOn succ:^{
        [ws.closeCameraButton setBackgroundImage:[UIImage imageNamed:(!isOn ? @"shelu_b" : @"shelu")]
                                        forState:UIControlStateNormal];
    }failed:^(NSString *moudle, int errId, NSString *errMsg) {
    }];
}

//typedef NS_ENUM(NSInteger, cameraPos) {
//    CameraPosFront = 0, ///< 前置摄像头
//    CameraPosBack  = 1, ///< 后置摄像头
//};
- (IBAction)swithcCamera:(id)sender {
    
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    int pos = [manager getCurCameraPos];
    
    if (pos == -1) {
        [self setText:@"摄像头没有打开"];
    }
    else {
        __weak typeof(self) ws = self;
        [manager switchCamera:^{
            [ws setText:@"切换摄像头成功"];
            [ws.swichCameraButton setBackgroundImage:[UIImage imageNamed:(!pos? @"zhuanhua_b" : @"zhuanhua")]
                                            forState:UIControlStateNormal];
        } failed:^(NSString *module, int errId, NSString *errMsg) {
            [ws setText:[NSString stringWithFormat:@"切换摄像头失败:%@-%d-%@",module,errId,errMsg]];
        }];
    }
}

- (IBAction)closeMic:(id)sender {
    
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    BOOL isOn = [manager getCurMicState];
    __weak typeof(self) ws = self;
    [manager enableMic:!isOn succ:^{
        NSString *text = !isOn ? @"打开麦克风成功" : @"关闭麦克风成功";
        [ws setText:text];
        [ws.closeMicButton setBackgroundImage:[UIImage imageNamed:(isOn? @"jingyin_b" : @"jingyin")]
                                     forState:UIControlStateNormal];
    } failed:^(NSString *moudle, int errId, NSString *errMsg) {
        NSString *text = !isOn?@"打开麦克风失败":@"关闭麦克风失败";
        [ws setText:[NSString stringWithFormat:@"%@:%@-%d-%@",text,moudle,errId,errMsg]];
    }];
}


- (IBAction)switchReceiver:(id)sender {
    
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    __weak typeof(self) ws = self;
    QAVOutputMode mode = [manager getCurAudioMode];
    [ws setText:(mode == QAVOUTPUTMODE_EARPHONE?@"切换扬声器成功":@"切换到听筒成功")];
    
    [ws.switchReceiverButton setBackgroundImage:[UIImage imageNamed:(mode == QAVOUTPUTMODE_EARPHONE?@"mianti_b" : @"mianti")]
                                       forState:UIControlStateNormal];
    if(mode == QAVOUTPUTMODE_EARPHONE){
        [manager setAudioMode:QAVOUTPUTMODE_SPEAKER];
    }
    else{
        [manager setAudioMode:QAVOUTPUTMODE_EARPHONE];
    }
}


/**
 隐藏 renderView
 */
- (IBAction)switchRenderView:(id)sender {
    
    BOOL flag = self.renderScroll.isHidden;
    
    if (!flag) {
        self.btnsView.hidden = !flag;
        [self.switchRenderButton setBackgroundImage:[UIImage imageNamed:@"quanping_b"] forState:UIControlStateNormal];
    }
    else {
        [self.switchRenderButton setBackgroundImage:[UIImage imageNamed:@"quanping"] forState:UIControlStateNormal];
    }
    
    self.renderScroll.hidden = !flag;
}


#pragma mark - 音视频事件回调
- (void)onMemberAudioOn:(BOOL)isOn members:(NSArray *)members
{
    
}

- (void)onMemberCameraVideoOn:(BOOL)isOn members:(NSArray *)members
{
    NSString *myId = [[ILiveLoginManager getInstance] getLoginId];
    
    if(isOn){
        for (TILCallMember *member in members) {
            
            NSString *identifier = member.identifier;
            
            if (![self.indexArray containsObject:identifier]) {
                [_call addRenderFor:identifier atFrame:CGRectZero];
                
                if ([identifier isEqualToString:myId]) {
                    [self.indexArray insertObject:identifier atIndex:0];
                    [self.statuArray insertObject:@"1" atIndex:0];
                } else {
                    [self.indexArray addObject:identifier];
                    [self.statuArray addObject:@"0"];
                }
            }
        }
    }
    else{
        for (TILCallMember *member in members) {
            
            NSString *identifier = member.identifier;
            
            NSInteger curIndex = [self.indexArray indexOfObject:identifier];
            
            [_call removeRenderFor:identifier];
            [self.indexArray removeObject:identifier];
            
            if ([self.statuArray[curIndex] isEqualToString:@"1"]) {
                if (curIndex == 0) {
                    [self.statuArray exchangeObjectAtIndex:curIndex withObjectAtIndex:1];
                }
                else {
                    [self.statuArray exchangeObjectAtIndex:curIndex withObjectAtIndex:0];
                }
            }
            
            [self.statuArray removeObjectAtIndex:curIndex];
        }
    }
    
    [self layoutRenderView];
    [self reloadMemberScroll];
}



#pragma mark - 通知回调
//注意：
//［通知回调］可以获取通话的事件通知
// [通话状态回调] 也可以获取通话的事件通知
- (void)onRecvNotification:(TILCallNotification *)notify
{
    //    TILCALL_NOTIF_ACCEPTED      = 0x82,
    //    TILCALL_NOTIF_CANCEL,
    //    TILCALL_NOTIF_TIMEOUT,
    //    TILCALL_NOTIF_REFUSE,
    //    TILCALL_NOTIF_HANGUP,
    //    TILCALL_NOTIF_LINEBUSY,
    //    TILCALL_NOTIF_HEARTBEAT     = 0x88,
    //    TILCALL_NOTIF_INVITE        = 0x89,
    //    TILCALL_NOTIF_DISCONNECT    = 0x8A,
    
    NSInteger notifId = notify.notifId;
    NSString *sender = notify.sender;
    NSString *target = [notify.targets componentsJoinedByString:@";"];
    NSString *myId = [[ILiveLoginManager getInstance] getLoginId];
    switch (notifId) {
        case TILCALL_NOTIF_INVITE:
            [self setText:[NSString stringWithFormat:@"%@邀请%@通话",sender,target]];
            break;
        case TILCALL_NOTIF_ACCEPTED:
            [self setText:[NSString stringWithFormat:@"%@接受了%@的邀请",sender,target]];
            //            [self setButtonEnable:YES];
            break;
        case TILCALL_NOTIF_CANCEL:
        {
            [self setText:[NSString stringWithFormat:@"%@取消了对%@的邀请",sender,target]];
            if([notify.targets containsObject:myId]){
                [self selfDismiss];
            }
        }
            break;
        case TILCALL_NOTIF_TIMEOUT:
        {
            if([sender isEqualToString:myId]){
                [self setText:[NSString stringWithFormat:@"%@呼叫超时",sender]];
                [self selfDismiss];
            }
            else{
                [self setText:[NSString stringWithFormat:@"%@手机可能不在身边",sender]];
            }
        }
            break;
        case TILCALL_NOTIF_REFUSE:
            [self setText:[NSString stringWithFormat:@"%@拒绝了%@的邀请",sender,target]];
            break;
        case TILCALL_NOTIF_HANGUP:
            [self setText:[NSString stringWithFormat:@"%@挂断了%@邀请的通话",sender,target]];
            break;
        case TILCALL_NOTIF_LINEBUSY:
            [self setText:[NSString stringWithFormat:@"%@占线，无法接受%@的邀请",sender,target]];
            break;
        case TILCALL_NOTIF_HEARTBEAT:
            [self setText:[NSString stringWithFormat:@"%@发来心跳",sender]];
            break;
        case TILCALL_NOTIF_DISCONNECT:
        {
            [self setText:[NSString stringWithFormat:@"%@失去连接",sender]];
            if([sender isEqualToString:myId]){
                [self selfDismiss];
            }
        }
            break;
        default:
            break;
    }
    
    [self.numberButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"number%lu", (unsigned long)self.membersArray.count]] forState:UIControlStateNormal];
}

- (NSTimer *)durationTimer {
    
    if (!_durationTimer) {
        _durationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(configDuration) userInfo:nil repeats:YES];
        
        [_durationTimer fire];
    }
    
    return _durationTimer;
}

- (void)configDuration {
    
    self.duration++;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.durationLabel.text = [self getDurationStr];
    });
}

- (NSString *)getDurationStr {
    
    if (self.duration < 60) {
        return [NSString stringWithFormat:@"00:%02d", self.duration];
    }
    else if (self.duration < 3600) {
        return [NSString stringWithFormat:@"%02d:%02d", self.duration / 60, self.duration % 60];
    }
    else {
        return [NSString stringWithFormat:@"%d:%02d:%02d", self.duration / 3600, (self.duration % 3600) / 60, (self.duration % 3600) % 60];
    }
}



#pragma mark - 界面管理

/**
 设置窗口
 */
- (void)layoutRenderView {
    
    for (UIView *subView in self.renderScroll.subviews) {
        [subView removeFromSuperview];
    }
    
    NSInteger bgIndex = [self.statuArray indexOfObject:@"1"];
    
    for (int i = 0; i < self.indexArray.count; i++) {
        
        ILiveRenderView *rv = [_call getRenderFor:self.indexArray[i]];
        rv.diffDirectionRenderMode = ILIVERENDERMODE_SCALEASPECTFILL;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [rv addGestureRecognizer:tap];
        
        CGRect frame;
        
        if (i < bgIndex) {
            
            frame = CGRectMake(i * (kRenderViewWidth + 10), 0, kRenderViewWidth, kRenderViewHeight);
            rv.frame = frame;
            [self.renderScroll addSubview:rv];
            [self.renderScroll addSubview:[self getRenderNameLabel:frame index:i]];
        }
        else if (i == bgIndex) {
            frame = self.view.bounds;
            rv.frame = frame;
            [self.view addSubview:rv];
            [self.view sendSubviewToBack:rv];
        }
        else {
            frame = CGRectMake((i - 1) * (kRenderViewWidth + 10), 0, kRenderViewWidth, kRenderViewHeight);
            rv.frame = frame;
            [self.renderScroll addSubview:rv];
            [self.renderScroll addSubview:[self getRenderNameLabel:frame index:i]];
        }
        
        
    }
    
    [self.numberButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"number%lu", (unsigned long)self.membersArray.count]] forState:UIControlStateNormal];
}

- (UILabel *)getRenderNameLabel:(CGRect)frame index:(int)i {
    CGRect labFrame = CGRectMake(frame.origin.x, frame.size.height - 20, frame.size.width, 20);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:labFrame];
    nameLabel.textAlignment = 1;
    nameLabel.attributedText = [CommonUtil getShadowStr:self.indexArray[i] font:12];
    return nameLabel;
}

- (void)tapClick:(UITapGestureRecognizer *)gesture {
    
    ILiveRenderView *rv = (id)gesture.view;
    if ([NSStringFromCGSize(rv.frame.size) isEqualToString:
         NSStringFromCGSize(self.view.frame.size)]) {
        self.btnsView.hidden = NO;
    }
    else {
        // 如果能进来这里就表示至少有两个人是开启摄像头的
        CGFloat x = rv.frame.origin.x;
        printf("x == %f", x);
        
        NSInteger bgIndex = [self.statuArray indexOfObject:@"1"];
        int tapIndex = x / kRenderViewWidth;
        
        tapIndex = tapIndex < bgIndex ? tapIndex : tapIndex + 1;
        
        [self.statuArray exchangeObjectAtIndex:tapIndex withObjectAtIndex:bgIndex];
        
        [self layoutRenderView];
    }
}

/**
 显示按钮
 
 @param isMake 以取消按钮是否显示为准
 */
//- (void)setEnableButton:(BOOL)isMake {
//    
//    self.cancelInviteButton.hidden = isMake;
//    self.btnsView.hidden = !isMake;
//}

/**
 设置窗口视图
 */
- (void)reloadMemberScroll {
    
    [self.membersArray removeAllObjects];
    [self.membersArray addObjectsFromArray:[_call getMembers]];
    
    for (UIView *subView in self.memberScroll.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i = 0; i < self.membersArray.count; i++) {
        TILCallMember *member = self.membersArray[i];
        NSString *identifier = member.identifier;
        
        UILabel *memberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 * i, 40, 40)];
        memberLabel.layer.cornerRadius = 20;
        memberLabel.layer.masksToBounds = YES;
        memberLabel.text = [CommonUtil getIconLabelStr:identifier];
        memberLabel.textColor = [UIColor whiteColor];
        memberLabel.backgroundColor = [UIColor colorWithRed:33 / 255.0 green:70 / 255.0 blue:93 / 255.0 alpha:1];
        memberLabel.textAlignment = 1;
        [self.memberScroll addSubview:memberLabel];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0 + 20, 50 * i + 20, 22, 22)];
        [self.memberScroll addSubview:image];
        image.image = [UIImage imageNamed:[self.indexArray containsObject:identifier] ? @"cameryOn" : @"cameryOff"];
    }
}

/**
 设置按钮视图图片
 */
- (void)resetButtonsView {
    
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    
    [self.closeCameraButton setBackgroundImage:[UIImage imageNamed:(![manager getCurCameraState]?  @"shelu_b" : @"shelu")]
                                      forState:UIControlStateNormal];
    
    [self.swichCameraButton setBackgroundImage:[UIImage imageNamed:([manager getCurCameraPos] ? @"zhuanhua_b" : @"zhuanhua")]
                                      forState:UIControlStateNormal];
    
    [self.closeMicButton setBackgroundImage:[UIImage imageNamed:(![manager getCurMicState]? @"jingyin_b" : @"jingyin")]
                                   forState:UIControlStateNormal];
    
    [self.switchReceiverButton setBackgroundImage:[UIImage imageNamed:([manager getCurAudioMode] == QAVOUTPUTMODE_SPEAKER  ? @"mianti_b" : @"mianti_b")]
                                         forState:UIControlStateNormal];
}
- (void)selfDismiss
{
    __weak typeof(self) ws = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    });
    
    
}

-(void)setText:(NSString *)log {
    
    NSLog(@"%@", log);
}


#pragma mark - segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"inviteMore"]) {
        
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        for (TILCallMember *member in self.membersArray) {
            [tempArr addObject:member.identifier];
        }
        
        UINavigationController *destinationNavi = [segue destinationViewController];
        CSInviteViewController *destinationController = (CSInviteViewController *)destinationNavi.topViewController;
        [destinationController setValue:tempArr
                                 forKey:@"inviteMoreArray"];
        
        __weak typeof(self) sself = self;
        destinationController.inviteBlock = ^(NSArray *inviteArray) {
            
            
            [sself.call inviteCall:inviteArray callTip:@"" custom:@"" result:^(TILCallError *err) {
                if (err) {
                    NSLog(@"邀请失败");
                } else {
                    NSLog(@"邀请成功");
                }
            }];
        };
    }
}


- (IBAction)btnViewClick:(id)sender {
    
    self.btnsView.hidden = YES;
}


- (IBAction)backClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
