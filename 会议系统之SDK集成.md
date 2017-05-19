# 腾讯直播SDK类
 * [TILCallSDK](https://github.com/zhaoyang21cn/CallSDK_iOS_Demo)

 > 基于ILiveSDK，实现双人视频(多人)业务功能封装，方便开发者快速搭建自己的视频聊天服务
 
 > TILCallSDK可以使用ILiveSDK的所有功能:
 > 
 > * 账号体系（资料托管）
 > * 群组管理
 > * 音视频通讯
 > * 美颜、美白
 > * 视频推流、录制
 
 * [ILiveSDK](https://github.com/zhaoyang21cn/ILiveSDK_iOS_Demos/blob/master/ILiveSDK-README.md)

 > (全称:Interactive Live SDK)整合了互动直播SDK(AVSDK)，即时通讯SDK(IMSDK)，登录服务(TLSSDK)等几大模块，致力于提供一套完整的音视频即时通讯解决方案，提供“连麦”，“多画面特效”，打造跨平台一对多，多对多的酷炫直播场景。ILiveSDK旨在无限可能的降低用户接入成本，从用户角度考虑问题，全方位考虑用户接入体验，并提供接入服务专业定向支持，为用户应用上线保驾护航，本文档目的在于帮助用户快速接入使用ILiveSDK,达到主播端画面本地渲染，观众端可进入房间观看主播端画面的效果。
 > ILiveSDK 提供了账号登录，音视频互动，文本互动等基础功能，顺利的话一天之内即可集成音视频能力。
 
 > * [视频直播类] 类似now直播,映客 一人直播,多人观看,发文本消息,赞,送礼物。[具体参考TILLiveSDK](https://github.com/zhaoyang21cn/ILiveSDK_iOS_Demos/blob/master/TILLiveSDK-README.md)
 > * [视频聊天类] 类似微信视频通话功能呢,支持多人同时上麦(最多4路)。具体参考TILCallSDK。[具体参考TILCallSDK](https://github.com/zhaoyang21cn/CallSDK_iOS_Demo)
 
 * [TILFilterSDK_1](https://github.com/zhaoyang21cn/ILiveSDK_iOS_Demos/blob/master/TILFilterSDK-README.md)
 > TILFilterSDK是为ILiveSDK量身定做的视频帧预处理插件，目前提供美颜美白功能及其他常用滤镜功能。集成步骤如下：
 >
 > 1. 初始化TILFilter对象
 > `self.tilFilter = [[TIFilter alloc] init];`
 > 2. 设置预处理回调
 > 	
 > 	IOS需要升级到ILiveSDK1.3.2
 > `[[ILiveRoomManager getInstance] setLocalVideoDelegate:self];`
 > 3. 处理数据
 >
 >  注意: IOS需要升级到ILiveSDK1.3.2
 >
 			- (void)OnLocalVideoPreProcess:(QAVVideoFrame *)frame
 			{
			    [self.tilFilter processData:frame.data
                            type:TILDataType_NV12
                            size:frame.dataSize
                           width:frame.frameDesc.width
                          height:frame.frameDesc.height];
          	}
 > 4. 设置滤镜
 > ###### 4.1 默认为美颜美白滤镜，可设置美颜美白
		[self.tilFilter setWhite:value];
		[self.tilFilter setBeauty:value];
 >	###### 4.2 设置其他滤镜（日系、怀旧、唯美等）
		[self.tilFilter setFilter:TILFilterType_RiXi];


# 多人视频
测通了注册和登录，返回userSig和token，用于后面的sdk使用，


TICallSDK使用的时候，独立模式和客户端接口调用的通道就是userSig、token，只需要用 userSig 去登陆，后面的内容就都是一样的了。

核心是直播还是互动直播，这个是值得深思的问题
也就是场景的不同，如果场景是一个会议室，每次开会的时候都是同级别的讨论问题，那么显然是互动直播
如果场景是不同级别的人，也就是领导、或者是有经验的人发布任务，或者是做一些推广的时候，使用直播的场景

“延时会受到码率和网络等其他因素的影响，，如果一味的追求延时低，可能其他方面比如画质就不会太理想了”

“自己的后台需要维护一些业务信息，比如直播房间列表，房间信息，房间号管理，心跳逻辑，用户昵称头像等”


#### 技术提供链接
* [SDK日志](https://www.qcloud.com/document/product/268/7752)
* [互动直播介绍](https://www.qcloud.com/document/product/268/3158)
* [切换分辨率码率](https://www.qcloud.com/document/product/268/7643)
* [查看直播质量](https://www.qcloud.com/document/product/268/7644)
* [腾讯云web播放器](http://live.qcloud.com/dy/test.html) - 将启动推流后得到的观看地址输入文本框即可播放
* 