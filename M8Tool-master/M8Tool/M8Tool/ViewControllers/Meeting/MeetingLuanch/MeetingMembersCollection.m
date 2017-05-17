//
//  MeetingMembersCollection.m
//  M8Tool
//
//  Created by chao on 2017/5/17.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "MeetingMembersCollection.h"



@interface MeetingMembersCollection ()<UICollectionViewDataSource, UICollectionViewDelegate>



@end


@implementation MeetingMembersCollection

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = WCRed;
        [self setBorder_bottom_color:WCBlack width:1];
        self.delegate   = self;
        self.dataSource = self;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"colcellidd"];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colcellidd" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


@end
