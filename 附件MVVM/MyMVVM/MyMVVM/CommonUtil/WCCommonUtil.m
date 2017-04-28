

#import "WCCommonUtil.h"

@implementation WCCommonUtil

+(BOOL)isFirstBuildVersion
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:@"Version"];
    NSString *curVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [defaults setObject:curVersion forKey:@"Version"];
    [defaults synchronize];
    
    if (lastVersion && [lastVersion isEqualToString:curVersion])
    {
        return NO;
    }
    
    return YES;
}

#pragma mark - 更改状态栏颜色
//白
+(void)changeStateBarWhite
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"statuBarColor"];
    [defaults synchronize];
}
//黑
+(void)changeStateBarBlack
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"statuBarColor"];
    [defaults synchronize];
}

@end
