# 会议系统

>  #define ShowAppId       @"1400025495"
> 
>  #define ShowAccountType @"11456"

## ILiveSDK集成和使用

### 修改随心播`ILiveSDK`

> 在随心播的`ILiveSDK`中添加`ILiveGLBaseView`
> 
> ILiveSDK -> ILiveRoomManager 最后添加方法
> 
```
 // 将外部渲染托管到界面上显示 
 - (ILiveGLBaseView *)glBaseView;
 - (void)bindGLView:(ILiveGLBaseView *)glview;
 - (ILiveGLBaseView *)createGLViewIn:(UIView *)view;
 - (ILiveGLBaseView *)createGLViewIn:(UIView *)view atRect:(CGRect)rect;
```


####【tips】
1. frameworks文件夹内容太大，上传不到GitHub，所以要将这个项目放到**[我的码云](https://git.oschina.net/wenchaoBlog)**上管理
2. AV.SDK还是超过了码云的限制，所以只能将frameworks的内容不放上去了，只将代码实现部分上传