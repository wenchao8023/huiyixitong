//
//  CSMakeCallViewController.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/7.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSMakeCallViewController.h"


static const int kRenderViewHeight = 160;
static const int kRenderViewWidth  = kRenderViewHeight * 3 / 4;
static const int kRenderViewSpace = 10;



@interface CSMakeCallViewController ()<TILCallNotificationListener,TILCallStatusListener, TILCallMemberEventListener>

@property (nonatomic, strong) TILC2CCall *call;
@property (nonatomic, strong) NSString *myId;

/****** 设置按钮 ******
 * 1.刚进来时 -- 呼叫对方，可以取消、不能结束会议，不提供设备操作
 * 2.呼叫失败 -- 退出视图
 * 3.呼叫成功 -- 不能取消，可以结束会议、提供设备操作
 */

/**
 缩小
 */
@property (weak, nonatomic) IBOutlet UIButton *switchRenderButton;


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



@property (nonatomic, strong, nonnull) UIScrollView *renderScroll;


//@property (nonatomic, strong, nonnull) NSArray *buttonsArray;

@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, strong, nonnull) NSMutableArray *statuArray;


@end

@implementation CSMakeCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _buttonsArray = @[self.switchRenderButton,
//                      self.closeCameraButton,
//                      self.swichCameraButton,
//                      self.closeMicButton,
//                      self.switchReceiverButton,
//                      self.cancelInviteButton,
//                      self.endComButton
//                      ];
    _indexArray = [[NSMutableArray alloc] init];
    
    _statuArray = [[NSMutableArray alloc] init];
    
    [self setEnableButton:NO];
    
    [self.view addSubview:self.renderScroll];
    [self.view sendSubviewToBack:self.renderScroll];

    
    [self makeCall];
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

#pragma mark - 通话接口
- (void)makeCall {
    
    if (_callType == CSCall_c2c) {
        [self makeCallC2C];
        
    } else {
        [self makeCallMult];
    }
}
#pragma mark -- 双人通话
-(void)makeCallC2C {
    
    TILCallConfig * config = [[TILCallConfig alloc] init];
    TILCallBaseConfig * baseConfig = [[TILCallBaseConfig alloc] init];
    baseConfig.callType = TILCALL_TYPE_VIDEO;
    baseConfig.isSponsor = YES;
    baseConfig.peerId = _peerId;
    baseConfig.heartBeatInterval = 15;
    config.baseConfig = baseConfig;
    
    TILCallListener * listener = [[TILCallListener alloc] init];
    //注意：
    //［通知回调］可以获取通话的事件通知，建议双人和多人都走notifListener
    // [通话状态回调] 也可以获取通话的事件通知
    listener.callStatusListener = self;
    listener.memberEventListener = self;
    listener.notifListener = self;
    
    config.callListener = listener;
    TILCallSponsorConfig *sponsorConfig = [[TILCallSponsorConfig alloc] init];
    sponsorConfig.waitLimit = 0;
    sponsorConfig.callId = (int)([[NSDate date] timeIntervalSince1970]) % 1000 * 1000 + arc4random() % 1000;
    sponsorConfig.onlineInvite = YES;
    config.sponsorConfig = sponsorConfig;
    
    _call = [[TILC2CCall alloc] initWithConfig:config];
    
    [_call createRenderViewIn:self.view];
    __weak typeof(self) ws = self;
    [_call makeCall:@"callTips" custom:@"callCustom" result:^(TILCallError *err) {
        if(err){
            [ws setText:[NSString stringWithFormat:@"呼叫失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
            [ws selfDismiss];
        }
        else{
             [ws setText:@"呼叫成功"];
            
            
        }
    }];
}
#pragma mark -- 多人通话
-(void)makeCallMult {
    
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

- (IBAction)cancelInvite:(id)sender {
    
    __weak typeof(self) ws = self;
    [_call cancelCall:^(TILCallError *err) {
        if(err){
            [ws setText:[NSString stringWithFormat:@"取消通话邀请失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
        }
        else{
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
        NSString *text = !isOn?@"打开摄像头成功":@"关闭摄像头成功";
        NSLog(@"%@", text);
        [ws.closeCameraButton setTitle:(!isOn?@"关闭摄像头":@"打开摄像头") forState:UIControlStateNormal];
    }failed:^(NSString *moudle, int errId, NSString *errMsg) {
        NSString *text = !isOn?@"打开摄像头失败":@"关闭摄像头失败";
        [ws setText:[NSString stringWithFormat:@"%@:%@-%d-%@",text,moudle,errId,errMsg]];
    }];
}

- (IBAction)swithcCamera:(id)sender {
    
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    __weak typeof(self) ws = self;
    [manager switchCamera:^{
        [ws setText:@"切换摄像头成功"];
    } failed:^(NSString *module, int errId, NSString *errMsg) {
        [ws setText:[NSString stringWithFormat:@"切换摄像头失败:%@-%d-%@",module,errId,errMsg]];
    }];
}

- (IBAction)closeMic:(id)sender {
    
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    BOOL isOn = [manager getCurMicState];
    __weak typeof(self) ws = self;
    [manager enableMic:!isOn succ:^{
        NSString *text = !isOn?@"打开麦克风成功":@"关闭麦克风成功";
        [ws setText:text];
        [ws.closeMicButton setTitle:(!isOn?@"关闭麦":@"打开麦") forState:UIControlStateNormal];
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
    [ws.switchReceiverButton setTitle:(mode == QAVOUTPUTMODE_EARPHONE?@"免提关":@"免提开") forState:UIControlStateNormal];
    if(mode == QAVOUTPUTMODE_EARPHONE){
        [manager setAudioMode:QAVOUTPUTMODE_SPEAKER];
    }
    else{
        [manager setAudioMode:QAVOUTPUTMODE_EARPHONE];
    }
}


- (IBAction)switchRenderView:(id)sender {
     [_call switchRenderView:_peerId with:_myId];
}

- (IBAction)backClick:(id)sender {
    
    //    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"结束会议");
}
- (IBAction)btnViewClick:(id)sender {
    
    self.btnsView.hidden = YES;
}

#pragma mark - 音视频事件回调
- (void)onMemberAudioOn:(BOOL)isOn members:(NSArray *)members
{
    
}

- (void)onMemberCameraVideoOn:(BOOL)isOn members:(NSArray *)members
{
    NSString *myId = [[ILiveLoginManager getInstance] getLoginId];
//    if(isOn){
//        for (TILCallMember *member in members) {
//            NSString *identifier = member.identifier;
//            
//            if([identifier isEqualToString:myId]){
//                [_call addRenderFor:myId atFrame:self.view.bounds];
//                [_call sendRenderViewToBack:myId];
//            }
//            else{
//                NSInteger count = _indexArray.count;
//                CGRect frame = [self getRenderFrame:count];
//                [_call addRenderFor:identifier atFrame:frame];
//                [_indexArray addObject:identifier];
//                [_call bringRenderViewToFront:identifier];
////                [self.view insertSubview:[_call getRenderFor:identifier] aboveSubview:[_call getRenderFor:myId]];
//            }
//        }
//    }
//    else{
//        for (TILCallMember *member in members) {
//            NSString *identifier = member.identifier;
//            if([identifier isEqualToString:myId]){
//                [_call removeRenderFor:identifier];
//                if(_indexArray.count == 0){
//                    NSString *firstIdentifier = _indexArray[0];
//                    [_call modifyRenderView:self.view.bounds forIdentifier:firstIdentifier];
//                    [_indexArray removeObject:firstIdentifier];
//                }
//            }
//            else{
//                [_call removeRenderFor:identifier];
//                [_indexArray removeObject:identifier];
//            }
//        }
//        [self updateRenderFrame];
//    }

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
        
        [self layoutRenderView];
        [self reloadMemberScroll];
    }
    else{
        for (TILCallMember *member in members) {
            NSString *identifier = member.identifier;
            if([identifier isEqualToString:myId]){
                [_call removeRenderFor:identifier];
                if(_indexArray.count == 0){
                    NSString *firstIdentifier = _indexArray[0];
                    [_call modifyRenderView:self.view.bounds forIdentifier:firstIdentifier];
                    [_indexArray removeObject:firstIdentifier];
                }
            }
            else{
                [_call removeRenderFor:identifier];
                [_indexArray removeObject:identifier];
            }
        }
        [self updateRenderFrame];
    }
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
    switch (notifId) {
        case TILCALL_NOTIF_ACCEPTED:
            [self setText:@"通话建立成功"];
            [self setEnableButton:YES];
            break;
        case TILCALL_NOTIF_TIMEOUT:
            [self setText:@"对方没有接听"];
            [self selfDismiss];
            break;
        case TILCALL_NOTIF_REFUSE:
            [self setText:@"对方拒绝接听"];
            [self selfDismiss];
            break;
        case TILCALL_NOTIF_HANGUP:
            [self setText:@"对方已挂断"];
            [self selfDismiss];
            break;
        case TILCALL_NOTIF_LINEBUSY:
            [self setText:@"对方占线"];
            [self selfDismiss];
            break;
        case TILCALL_NOTIF_HEARTBEAT:
            [self setText:[NSString stringWithFormat:@"%@发来心跳",sender]];
            break;
        case TILCALL_NOTIF_DISCONNECT:
            [self setText:@"对方失去连接"];
            [self selfDismiss];
            break;
        default:
            break;
    }
}

#pragma mark - 通话状态事件回调
//- (void)onCallEstablish{
//    [self setText:@"通话建立成功"];
//    [self setEnableButton:YES];
//}
//
//- (void)onCallEnd:(TILCallEndCode)code{
//    switch (code) {
//        case TILCALL_END_SPONSOR_TIMEOUT:
//            [self setText:@"对方没有接听"];
//            break;
//        case TILCALL_END_RESPONDER_REFUSE:
//            [self setText:@"接受方已拒绝"];
//            break;
//        case TILCALL_END_PEER_HANGUP:
//            [self setText:@"对方已挂断"];
//            break;
//        case TILCALL_END_RESPONDER_LINEBUSY:
//            [self setText:@"对方正忙"];
//            break;
//        default:
//            break;
//    }
//    [self selfDismiss];
//}


#pragma mark - 界面管理

- (void)layoutRenderView {
    
    for (UIView *subView in self.renderScroll.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i = 0; i < self.indexArray.count; i++) {
        ILiveRenderView *rv = [_call getRenderFor:self.indexArray[i]];
        rv.diffDirectionRenderMode = ILIVERENDERMODE_SCALEASPECTFILL;
        CGRect frame = CGRectMake(i * (kRenderViewWidth + 10), 0, kRenderViewWidth, kRenderViewHeight);
        rv.frame = frame;
        [self.renderScroll addSubview:rv];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [rv addGestureRecognizer:tap];
        
        if ([self.statuArray[i] isEqualToString:@"1"]) {
            
            ILiveRenderView *bgrv = [_call getRenderFor:self.indexArray[i]];
            bgrv.diffDirectionRenderMode = ILIVERENDERMODE_SCALEASPECTFILL;
            CGRect frame = self.view.bounds;
            bgrv.frame = frame;
            [self.view addSubview:bgrv];
            [self.view sendSubviewToBack:bgrv];
        }
    }
    
    [self.numberButton setTitle:[NSString stringWithFormat:@"%lu", self.indexArray.count] forState:UIControlStateNormal];
}

- (void)tapClick:(UITapGestureRecognizer *)gesture {
    
    ILiveRenderView *rv = (id)gesture.view;
    if ([NSStringFromCGSize(rv.frame.size) isEqualToString:
        NSStringFromCGSize(self.view.frame.size)]) {
        self.btnsView.hidden = NO;
    }
}


- (CGRect)getRenderFrame:(NSInteger)count{
    if(count == 3){
        return CGRectZero;
    }

    CGFloat x = kRenderViewSpace + (count * (kRenderViewWidth + kRenderViewSpace));
    CGFloat y = HEIGHT - kRenderViewSpace - kRenderViewHeight;
    return CGRectMake(x, y, kRenderViewWidth, kRenderViewHeight);
}

- (void)updateRenderFrame{
    for(NSInteger index = 0; index < _indexArray.count; index++){
        CGRect frame = [self getRenderFrame:index];
        NSString *identifier = _indexArray[index];
        [_call modifyRenderView:frame forIdentifier:identifier];
    }
}

- (void)setEnableButton:(BOOL)isMake {

    self.cancelInviteButton.hidden = isMake;
    self.btnsView.hidden = !isMake;
//    for (UIButton *btn in self.buttonsArray) {
//        
//        btn.hidden = !isMake;
//        
//        if ([btn isEqual:self.cancelInviteButton]) {
//            btn.hidden = isMake;
//        }
//    }
}

- (void)reloadMemberScroll {
    
    for (UIView *subView in self.memberScroll.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i = 0; i < self.indexArray.count; i++) {
        UILabel *memberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 * i, 40, 40)];
        memberLabel.layer.cornerRadius = 20;
        memberLabel.layer.masksToBounds = YES;
        memberLabel.text = [CommonUtil getIconLabelStr:self.indexArray[i]];
        memberLabel.textColor = [UIColor whiteColor];
        memberLabel.backgroundColor = [UIColor greenColor];
        memberLabel.textAlignment = 1;
        [self.memberScroll addSubview:memberLabel];
    }
    
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
