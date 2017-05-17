//
//  MeetingButtonsCollection.m
//  M8Tool
//
//  Created by chao on 2017/5/15.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "MeetingButtonsCollection.h"
#import "MeetingButtonsCell.h"
#import "RecordViewController.h"

@interface MeetingButtonsCollection ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@end


@implementation MeetingButtonsCollection

- (NSArray *)titleArray {
    if (!_titleArray) {
        NSArray *titleArray = @[@"电话会议", @"视频会议", @"直播会议", @"手机通话",
                                @"预约会议", @"会议笔记", @"会议收藏", @"通讯录"];
        _titleArray = titleArray;
    }
    return _titleArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    WCCollectionViewHorizontalLayout *layout = [[WCCollectionViewHorizontalLayout alloc] initWithRowCount:2 itemCountPerRow:4];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 4, SCREEN_WIDTH / 4);
    layout.scrollDirection          = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing       = 0;
    layout.headerReferenceSize      = CGSizeMake(0, 0);
    layout.minimumInteritemSpacing  = 0;
    
    
    self.collectionViewLayout   = layout;
    self.delegate               = self;
    self.dataSource             = self;
    self.scrollEnabled          = NO;
    
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([MeetingButtonsCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MeetingButtonsCellID"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MeetingButtonsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MeetingButtonsCellID" forIndexPath:indexPath];
    
    [cell configWithTitle:self.titleArray[indexPath.row] imageStr:@""];
    
    [cell setBorder_bottom_color:[UIColor colorWithRed:0.09 green:0.09 blue:0.09 alpha:1] width:1];
    
    if ((indexPath.row + 1) % 4) {
        [cell setBorder_right_color:[UIColor colorWithRed:0.09 green:0.09 blue:0.09 alpha:1] width:1];
    }
    
    if (indexPath.row < 4) {
        [cell setBorder_top_color:[UIColor colorWithRed:0.09 green:0.09 blue:0.09 alpha:1] width:1];
    }
    
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSLog(@"第 %f 页", self.contentOffset.x / SCREEN_WIDTH);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WCLog(@"点击第 %ld 个按钮", (long)indexPath.row);
    
    
    if (indexPath.row == 5 ||
        indexPath.row == 6) {
        RecordViewController *recordvc = [[RecordViewController alloc] init];
        recordvc.recordViewType = indexPath.row - 4;
        recordvc.isExitLeftItem = YES;
        [[[AppDelegate sharedAppDelegate] navigationViewController] pushViewController:recordvc animated:YES];
    }
}


@end
