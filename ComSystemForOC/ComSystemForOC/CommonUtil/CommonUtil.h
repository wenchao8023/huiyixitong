//
//  CommonUtil.h
//  ComSystemForOC
//
//  Created by chao on 2017/4/7.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

+(void)saveUserID:(NSString *)userid ;

+(NSString *)getUserID ;

+(NSString *)getIconLabelStr:(NSString *)str ;

// 文字模糊背景
// 默认：白色文字、黑色模糊
// 文字默认 16
+(NSMutableAttributedString *)getShadowStr:(NSString *)str ;

+(NSMutableAttributedString *)getShadowStr:(NSString *)str font:(CGFloat)font ;

+(NSMutableAttributedString *)getShadowStr:(NSString *)str textColor:(UIColor *)textColor shadowColor:(UIColor *)shadowColor ;

@end
