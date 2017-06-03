//
//  CommonUtil.m
//  M8Tool
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
#pragma mark - 文本属性


/**
 自定义大小，字体为 DroidSansFallback 的文本
 
 @param string 修饰文本
 @return 返回自定义 大小 字体文本属性
 */
+(NSMutableAttributedString *)customAttString:(NSString *)string
                                     fontSize:(CGFloat)fontSize
{
    return [self customAttString:string
                        fontSize:fontSize
                       textColor:nil];
}

+(NSMutableAttributedString *)customAttString:(NSString *)string
                                     fontSize:(CGFloat)fontSize
                                    textColor:(UIColor *)textColor
{
    return [self customAttString:string
                        fontSize:fontSize
                       textColor:textColor
                       charSpace:0];
}


+(NSMutableAttributedString *)customAttString:(NSString *)string
                                     fontSize:(CGFloat)fontSize
                                    textColor:(UIColor *)textColor
                                    charSpace:(int)charSpace
{
    return [[NSMutableAttributedString alloc] initWithString:string
                                                  attributes:[self customAttsWithFontSize:fontSize
                                                                                textColor:textColor
                                                                                charSpace:charSpace]];
}
+(NSMutableAttributedString *)customAttString:(NSString *)string
                                     fontSize:(CGFloat)fontSize
                                    textColor:(UIColor *)textColor
                                    charSpace:(int)charSpace
                                     fontName:(NSString *)fontName
{
    if (string)
        return [[NSMutableAttributedString alloc] initWithString:string
                                                      attributes:[self customAttsWithFontSize:fontSize
                                                                                    textColor:textColor
                                                                                    charSpace:charSpace
                                                                                     fontName:fontName]];
    return nil;
}

+(NSMutableDictionary *)customAttsWithFontSize:(CGFloat)fontSize
                                     textColor:(UIColor *)textColor
                                     charSpace:(int)charSpace {
    NSMutableDictionary *attDict = [NSMutableDictionary dictionaryWithCapacity:0];
    //设置字体、大小
    [attDict setValue:[UIFont fontWithName:kFontNameHeiti_SC size:fontSize] forKey:NSFontAttributeName];
    //设置字体颜色
    if (textColor)
        [attDict setValue:textColor forKey:NSForegroundColorAttributeName];
    //设置字符间距
    if (charSpace)
        [attDict setValue:@(charSpace) forKey:NSKernAttributeName];
    return attDict;
}
+(NSMutableDictionary *)customAttsWithFontSize:(CGFloat)fontSize
                                     textColor:(UIColor *)textColor
                                     charSpace:(int)charSpace
                                      fontName:(NSString *)fontName
{
    NSMutableDictionary *attDict = [NSMutableDictionary dictionaryWithCapacity:0];
    //设置字体、大小
    [attDict setValue:[UIFont fontWithName:fontName size:fontSize] forKey:NSFontAttributeName];
    //设置字体颜色
    if (textColor)
        [attDict setValue:textColor forKey:NSForegroundColorAttributeName];
    //设置字符间距
    if (charSpace)
        [attDict setValue:@(charSpace) forKey:NSKernAttributeName];
    return attDict;
}

+(NSMutableAttributedString *)nonusecustomAttString:(NSString *)string {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableDictionary *attDict = [NSMutableDictionary dictionaryWithCapacity:0];
    //设置字体 (默认大小)
    [attDict setValue:[UIFont fontWithName:@"DroidSansFallback" size:0] forKey:NSFontAttributeName];
    //设置字体颜色
    [attDict setValue:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    //设置字体背景颜色
    [attDict setValue:[UIColor clearColor] forKey:NSBackgroundColorAttributeName];
    //设置字符间距
    [attDict setValue:@(4) forKey:NSKernAttributeName];
    
    //段落属性
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraph.lineSpacing = 10;
    //段落间距
    paragraph.paragraphSpacing = 20;
    //对齐方式
    paragraph.alignment = NSTextAlignmentLeft;
    //指定段落开始的缩进像素
    paragraph.firstLineHeadIndent = 30;
    //调整全部文字的缩进像素
    paragraph.headIndent = 10;
    
    //设置段落属性
    [attDict setValue:paragraph forKey:NSParagraphStyleAttributeName];
    
    [attString setAttributes:attDict range:NSMakeRange(0, string.length)];
    return attString;
}

@end
