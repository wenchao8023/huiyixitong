

#import <Foundation/Foundation.h>

@interface WCCommonUtil : NSObject
/**
 *  判断是不是第一次进入这个版本
 */
+(BOOL)isFirstBuildVersion;

/**
 *  改变状态栏的颜色为白色
 */
+(void)changeStateBarWhite;

/**
 *  改变状态栏的颜色为黑色
 */
+(void)changeStateBarBlack;

@end
