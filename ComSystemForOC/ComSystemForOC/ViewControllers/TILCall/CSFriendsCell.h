//
//  CSFriendsCell.h
//  ComSystemForOC
//
//  Created by chao on 2017/4/5.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSFriendsCell : UITableViewCell

-(void)configWithSelected:(NSString *)nameStr;

-(void)configWithUnSelected:(NSString *)nameStr;

-(void)configSelf:(NSString *)nameStr;
@end
