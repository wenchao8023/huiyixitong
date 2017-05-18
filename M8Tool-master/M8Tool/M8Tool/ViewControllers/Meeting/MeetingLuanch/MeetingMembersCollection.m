//
//  MeetingMembersCollection.m
//  M8Tool
//
//  Created by chao on 2017/5/17.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "MeetingMembersCollection.h"
#import "MeetingMembersCell.h"


static NSString *CollectionHeaderID = @"MeetingMembersCollectionHeaderID";
///////////////////////////////////////////////////////////////
@interface MembersCollectionHeader : UICollectionReusableView

@end

@implementation MembersCollectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UILabel *titleLabel = [WCUIKitControl createLabelWithFrame:CGRectMake(20, 0, 80, 40)
                                                              Text:@"参会人员"
                                                          FontSize:kAppMiddleFontSize
                                                           BgColor:WCClear];
        [self addSubview:titleLabel];
        
        CGFloat x = CGRectGetMaxX(titleLabel.frame);
        
        UILabel *numbersLabel = [WCUIKitControl createLabelWithFrame:CGRectMake(x, 0, SCREEN_WIDTH - x - 20, 40)
                                                                Text:@""
                                                            FontSize:kAppMiddleFontSize
                                                       TextAlignment:0
                                                           TextColor:[UIColor colorWithRed:0.27 green:0.48 blue:0.45 alpha:1]
                                                             BgColor:WCClear];
        numbersLabel.tag = 64;
        [self addSubview:numbersLabel];
    }
    return self;
}

- (void)setNumbersWithCurrentNumbers:(NSInteger)currenNumbers totalNumbers:(NSInteger)totalNumbers {
    UILabel *numbersLabel = [self viewWithTag:64];
    NSString *textStr = [NSString stringWithFormat:@"%ld/%ld（最多可邀请%ld人）", (long)currenNumbers, (long)totalNumbers, (long)totalNumbers];
    [numbersLabel setAttributedText:[CommonUtil customAttString:textStr fontSize:kAppMiddleFontSize]];
}

@end
///////////////////////////////////////////////////////////////


@interface MeetingMembersCollection ()<UICollectionViewDataSource, UICollectionViewDelegate>

//@property (nonatomic, strong) MembersCollectionHeader *collectionHeader;

@end




@implementation MeetingMembersCollection

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = WCClear;
        self.delegate   = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        [self registerNib:[UINib nibWithNibName:@"MeetingMembersCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MeetingMembersCellID"];
        [self registerClass:[MembersCollectionHeader class]
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
    cell.backgroundColor = WCBlack;
    WCViewBorder_Radius(cell, self.width / 8);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MembersCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                             withReuseIdentifier:CollectionHeaderID
                                                                                    forIndexPath:indexPath];
        [header setNumbersWithCurrentNumbers:self.currenNumbers totalNumbers:self.totalNumbers];
        return header;
    }
    return nil;
}


@end