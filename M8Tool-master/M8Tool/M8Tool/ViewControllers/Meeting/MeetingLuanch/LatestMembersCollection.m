//
//  LatestMembersCollection.m
//  M8Tool
//
//  Created by chao on 2017/5/18.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "LatestMembersCollection.h"
#import "MeetingMembersCell.h"


static NSString *CollectionHeaderID = @"LatestMembersCollectionHeaderID";
///////////////////////////////////////////////////////////////
@interface LatestCollectionHeader : UICollectionReusableView

@end

@implementation LatestCollectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = WCBgColor;
        UILabel *titleLabel = [WCUIKitControl createLabelWithFrame:CGRectMake(20, 0, 80, 40)
                                                              Text:@"最近联系人"
                                                          FontSize:kAppMiddleFontSize
                                                           BgColor:WCClear];
        [self addSubview:titleLabel];
    }
    return self;
}
@end
///////////////////////////////////////////////////////////////






@interface LatestMembersCollection ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//@property (nonatomic, strong) MembersCollectionHeader *collectionHeader;

@end




@implementation LatestMembersCollection

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = WCClear;
        self.delegate   = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"MeetingMembersCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MeetingMembersCellID"];
        [self registerClass:[LatestCollectionHeader class]
 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
        withReuseIdentifier:CollectionHeaderID];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MeetingMembersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MeetingMembersCellID" forIndexPath:indexPath];
    cell.backgroundColor = WCRed;
    WCViewBorder_Radius(cell, self.width / 8);
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LatestCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                             withReuseIdentifier:CollectionHeaderID
                                                                                    forIndexPath:indexPath];
        return header;
    }
    return nil;
}



@end
