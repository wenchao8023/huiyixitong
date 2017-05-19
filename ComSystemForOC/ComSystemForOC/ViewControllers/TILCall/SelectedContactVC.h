//
//  SelectedContactVC.h
//  ComSystemForOC
//
//  Created by chao on 2017/4/10.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QuedingBlock)(NSArray * _Nonnull dataArr);

@interface SelectedContactVC : UITableViewController

@property (nonatomic, strong, nonnull) NSMutableArray *dataArray;

@property (nonatomic, copy, nullable) QuedingBlock quedingBlock;

@end
