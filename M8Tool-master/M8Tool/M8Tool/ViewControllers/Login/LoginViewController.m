//
//  LoginViewController.m
//  TILLiveSDKShow
//
//  Created by wilderliao on 16/11/7.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "UserProtocolViewController.h"
#import "LoginManager.h"
#import "MainTabBarController.h"


@interface LoginViewController () <RegistViewControllerDelegate>

@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)showRegistUserIdentifier:(NSString *)identifier
{
    _userNameTF.text = identifier;
}

- (void)showRegistUserPwd:(NSString *)passward
{
    _passwordTF.text = passward;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WCLightGray;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"登录";
    self.navigationItem.title = @"用户名登录";
    
    [self addTapBlankToHideKeyboardGesture];
//    [self autoLogin];
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat screenW = screenRect.size.width;
    CGFloat tfHeight = 44;
    int index = 0;
    
    _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kDefaultMargin*(index+2) + tfHeight*index, screenW-(kDefaultMargin*4), tfHeight)];
    _userNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultMargin, kDefaultMargin)];
    _userNameTF.leftViewMode = UITextFieldViewModeAlways;
    _userNameTF.backgroundColor = WCWhite;
    _userNameTF.layer.borderWidth = 0.5;
    _userNameTF.layer.borderColor = WCGray.CGColor;
    _userNameTF.layer.cornerRadius = 5.0;
    _userNameTF.placeholder = @"用户名";
//    _userNameTF.text = @"wilder2";
    [self.view addSubview:_userNameTF];
    index++;
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kDefaultMargin*(index+2) + tfHeight*index, screenW-(kDefaultMargin*4), tfHeight)];
    _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultMargin, kDefaultMargin)];
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultMargin, kDefaultMargin)];
    _passwordTF.backgroundColor = WCWhite;
    _passwordTF.layer.borderWidth = 0.5;
    _passwordTF.layer.borderColor = WCGray.CGColor;
    _passwordTF.layer.cornerRadius = 5.0;
    _passwordTF.placeholder = @"密码";
//    _passwordTF.text = @"123123123";
    [self.view addSubview:_passwordTF];
    index++;
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kDefaultMargin*(index+2) + tfHeight*index, screenW-(kDefaultMargin*4), tfHeight)];
    loginBtn.backgroundColor = WCRed;
    loginBtn.layer.cornerRadius = 5.0;
    [loginBtn setAttributedTitle:[CommonUtil customAttString:@"登录"
                                                    fontSize:kAppMiddleFontSize
                                                   textColor:WCWhite
                                                   charSpace:kAppKern_0]
                        forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(onLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    index++;
    
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenW - kDefaultMargin - 100, kDefaultMargin*(index+2) + tfHeight*index, 100, tfHeight)];
    registBtn.layer.cornerRadius = 5.0;
    [registBtn setAttributedTitle:[CommonUtil customAttString:@"注册新用户"
                                                    fontSize:kAppMiddleFontSize
                                                   textColor:WCWhite
                                                   charSpace:kAppKern_0]
                        forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(onRegist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    index++;
}

- (void)addTapBlankToHideKeyboardGesture;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlankToHideKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)onTapBlankToHideKeyboard:(UITapGestureRecognizer *)ges
{
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
}

- (void)showAlert:(NSString *)title message:(NSString *)msg okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle ok:(ActionHandle)succ cancel:(ActionHandle)fail
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    if (okTitle)
    {
        [alert addAction:[UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:succ]];
    }
    if (cancelTitle)
    {
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:fail]];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

//- (void)autoLogin
//{
//    NSDictionary *dic = [self getLocalLoginParam];
//    if (dic)
//    {
//        NSString *identifier = [dic objectForKey:kLoginIdentifier];
//        NSString *passward = [dic objectForKey:kLoginPassward];
//        if (identifier.length > 0 && passward.length > 0)
//        {
//            [self login:identifier passward:passward];
//        }
//    }
//}

- (void)onLogin:(UIButton *)button
{
    if (!_userNameTF || _userNameTF.text.length < 1)
    {
        [self showAlert:@"提示" message:@"用户名无效" okTitle:@"确定" cancelTitle:nil ok:nil cancel:nil];
        return;
    }
    if (!_passwordTF || _passwordTF.text.length < 1)
    {
        [self showAlert:@"提示" message:@"密码无效" okTitle:@"确定" cancelTitle:nil ok:nil cancel:nil];
        return;
    }
    WCWeakSelf(self);
//    [self login:_userNameTF.text passward:_passwordTF.text];
    LoginManager *manager = [LoginManager new];
    manager.loginTypeBlock = ^(LoginType type){
        if (type == LoginType_Succ) {
            [weakself enterMainUI];
        }
    };
    [manager login:_userNameTF.text passward:_passwordTF.text click:YES];
}

//- (void)login:(NSString *)identifier passward:(NSString *)pwd
//{
//    LoadView *loginWaitView = [LoadView loadViewWith:@"正在登录"];
//    [self.view addSubview:loginWaitView];
//    
//    __weak typeof(self) ws = self;
//    //请求sig
//    LoginRequest *sigReq = [[LoginRequest alloc] initWithHandler:^(BaseRequest *request) {
//        LoginResponceData *responseData = (LoginResponceData *)request.response.data;
//        [AppDelegate sharedAppDelegate].token = responseData.token;
//        [[ILiveLoginManager getInstance] iLiveLogin:identifier sig:responseData.userSig succ:^{
//            NSLog(@"tillivesdkshow login succ");
//            [loginWaitView removeFromSuperview];
//            [ws saveLoginParamToLocal:identifier passward:pwd];
//            [ws enterMainUI];
//            
//            [CommonUtil saveUserID:identifier];
//            
//        } failed:^(NSString *module, int errId, NSString *errMsg) {
//            [loginWaitView removeFromSuperview];
//            if (errId == 8050)//离线被踢,再次登录
//            {
//                [ws login:identifier passward:pwd];
//            }
//            else
//            {
//                NSString *errInfo = [NSString stringWithFormat:@"module=%@,errid=%d,errmsg=%@",module,errId,errMsg];
//                NSLog(@"login fail.%@",errInfo);
//                [ws showAlert:@"登录失败" message:errInfo okTitle:@"确定" cancelTitle:nil ok:nil cancel:nil];
//            }
//        }];
//    } failHandler:^(BaseRequest *request) {
//        [loginWaitView removeFromSuperview];
//        NSString *errInfo = [NSString stringWithFormat:@"errid=%ld,errmsg=%@",(long)request.response.errorCode, request.response.errorInfo];
//        NSLog(@"login fail.%@",errInfo);
//        [ws showAlert:@"登录失败" message:errInfo okTitle:@"确定" cancelTitle:nil ok:nil cancel:nil];
//    }];
//    sigReq.identifier = identifier;
//    sigReq.pwd = pwd;
//    [[WebServiceEngine sharedEngine] asyncRequest:sigReq];
//}
//
//- (void)saveLoginParamToLocal:(NSString *)identifier passward:(NSString *)pwd
//{
//    NSMutableDictionary *loginParam = [NSMutableDictionary dictionary];
//    [loginParam setObject:identifier forKey:kLoginIdentifier];
//    [loginParam setObject:pwd forKey:kLoginPassward];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:loginParam forKey:kLoginParam];
//    [userDefaults synchronize];
//}
//
//- (NSDictionary *)getLocalLoginParam
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dic = [userDefaults objectForKey:kLoginParam];
//    return dic;
//}

- (void)onRegist:(UIButton *)button
{
    RegistViewController *registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
    registVC.delegate = self;
}

- (void)enterMainUI
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *has = [[NSUserDefaults standardUserDefaults] objectForKey:kUserProtocol];
    if (!has || !has.boolValue)
    {
        UserProtocolViewController *vc = [[UserProtocolViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        appDelegate.window.rootViewController = nav;
        return;
    }
    
    MainTabBarController *tabBarVC = [[MainTabBarController alloc] init];
    appDelegate.window.rootViewController = tabBarVC;
    
    [self rememberLoginStatu];
}

- (void)rememberLoginStatu {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(YES) forKey:kHasLogin];
    [defaults synchronize];
}
@end
