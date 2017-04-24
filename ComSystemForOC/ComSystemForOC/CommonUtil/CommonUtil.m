//
//  CommonUtil.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/7.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil


+(void)saveUserID:(NSString *)userid {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:userid forKey:@"loginUserid"];
    
    [def synchronize];
}

+(NSString *)getUserID {
    
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"loginUserid"];
}

+(NSString *)getIconLabelStr:(NSString *)str {
    
    if (str.length <= 2) {
        return str;
        
    } else if (str.length <=3) {
        return [str substringFromIndex:1];
        
    } else if (str.length <= 4) {
        return [str substringFromIndex:2];
        
    } else {
        return [str substringToIndex:2];
    }
}

// 文字模糊背景
// 默认：白色文字、黑色模糊
// 文字大小 16
+(NSMutableAttributedString *)getShadowStr:(NSString *)str {
    
    NSRange range = NSMakeRange(0, str.length);
    
    NSShadow *shadow = [[NSShadow alloc] init];
    
    shadow.shadowBlurRadius = 5;    //模糊度
    
    shadow.shadowColor = [UIColor blackColor];
    
    shadow.shadowOffset = CGSizeMake(1, 3);
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:16],
                           NSForegroundColorAttributeName : [UIColor whiteColor],
                           NSShadowAttributeName : shadow};
    
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attText setAttributes:dict range:range];
    
    return attText;
}

+(NSMutableAttributedString *)getShadowStr:(NSString *)str font:(CGFloat)font {
    
    NSRange range = NSMakeRange(0, str.length);
    
    NSShadow *shadow = [[NSShadow alloc] init];
    
    shadow.shadowBlurRadius = 5;    //模糊度
    
    shadow.shadowColor = [UIColor blackColor];
    
    shadow.shadowOffset = CGSizeMake(1, 3);
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:font],
                           NSForegroundColorAttributeName : [UIColor whiteColor],
                           NSShadowAttributeName : shadow};
    
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attText setAttributes:dict range:range];
    
    return attText;
}

+(NSMutableAttributedString *)getShadowStr:(NSString *)str textColor:(UIColor *)textColor shadowColor:(UIColor *)shadowColor {
    
    NSRange range = NSMakeRange(0, str.length);
    
    NSShadow *shadow = [[NSShadow alloc] init];
    
    shadow.shadowBlurRadius = 5;    //模糊度
    
    shadow.shadowColor = shadowColor;
    
    shadow.shadowOffset = CGSizeMake(1, 3);
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:16],
                           NSForegroundColorAttributeName : textColor,
                           NSShadowAttributeName : shadow};
    
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attText setAttributes:dict range:range];
    
    return attText;
}

@end
