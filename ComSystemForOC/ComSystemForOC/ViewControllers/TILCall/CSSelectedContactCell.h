//
//  CSSelectedContactCell.h
//  ComSystemForOC
//
//  Created by chao on 2017/4/10.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DelBlock)();

@interface CSSelectedContactCell : UITableViewCell

@property (nonatomic, copy, nullable) DelBlock delBlock;
-(void)config:(NSString * _Nonnull)str;

@end
