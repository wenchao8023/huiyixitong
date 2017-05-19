//
//  MeetingMembersCollection.h
//  M8Tool
//
//  Created by chao on 2017/5/17.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import <UIKit/UIKit.h>




/**
 添加 和 移除 之后的数据都要和 最近联系人是否选中状态同步
 */
@protocol MeetingMembersCollectionDelegate <NSObject>

- (void)MeetingMembersCollectionSelectedMembers:(NSString *)delNameStr;

- (void)MeetingMembersCollectionContentHeight:(CGFloat)contentHeight;

@end

@interface MeetingMembersCollection : UICollectionView

@property (nonatomic, assign) NSInteger currenNumbers;

@property (nonatomic, assign) NSInteger totalNumbers;

@property (nonatomic, weak) id WCDelegate;


- (void)syncDataMembersArrayWithDic:(NSDictionary *)memberInfo ;

@end
