//
//  MeetingLuanchTableView.m
//  M8Tool
//
//  Created by chao on 2017/5/17.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "MeetingLuanchTableView.h"
#import "MeetingMembersCollection.h"
#import "LatestMembersCollection.h"
#import "MeetingLuanchTableViewCell.h"





#define kItemWidth (self.width - 60) / 5
#define kSectionHeight 40





///////////////////////////////////////////////////
#pragma mark - header image in live_type
@interface TBheaderView : UIImageView

@end


@implementation TBheaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

@end
///////////////////////////////////////////////////








/*************************************************/
#pragma mark - CollectionView >  flowLayout
@interface MyFlowLayout : UICollectionViewFlowLayout


@end

@implementation MyFlowLayout

- (instancetype)initWithHeaderSize:(CGSize)headerSize itemSize:(CGSize)itemSize {
    if (self = [super init]) {
        self.sectionHeadersPinToVisibleBounds = YES;
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        self.headerReferenceSize = headerSize;
        self.itemSize = itemSize;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}
@end
/*************************************************/



///////////////////////////////////////////////////
#pragma mark - tableView > footerView: LatestMembersCollection + MeetingMembersCollection
@interface TBFooterView : UIView<MeetingMembersCollectionDelegate, LatestMembersCollectionDelegate>

@property (nonatomic, strong) LatestMembersCollection   *latestCollection;
@property (nonatomic, strong) MeetingMembersCollection  *membersCollection;

@end


@implementation TBFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self membersCollection];
        self.membersCollection.WCDelegate   = self;
        
        [self latestCollection];
        self.latestCollection.WCDelegate    = self;
    }
    return self;
}

- (MeetingMembersCollection *)membersCollection {
    if (!_membersCollection) {
        CGRect membersFrame = self.bounds;
        membersFrame.size.height = kSectionHeight + kItemWidth;
        MeetingMembersCollection *membersCollection = [[MeetingMembersCollection alloc] initWithFrame:membersFrame
                                                                                 collectionViewLayout:[[MyFlowLayout alloc] initWithHeaderSize:CGSizeMake(self.width, kSectionHeight)
                                                                                                                                      itemSize:CGSizeMake(kItemWidth, kItemWidth)]];
        [self addSubview:(_membersCollection = membersCollection)];
    }
    return _membersCollection;
}

- (LatestMembersCollection *)latestCollection {
    if (!_latestCollection) {
        CGRect latestFrame = self.bounds;
        latestFrame.origin.y    = CGRectGetMaxY(self.membersCollection.frame);
        latestFrame.size.height -= CGRectGetMaxY(self.membersCollection.frame);
        LatestMembersCollection *latestCollection = [[LatestMembersCollection alloc] initWithFrame:latestFrame
                                                                                 collectionViewLayout:[[MyFlowLayout alloc] initWithHeaderSize:CGSizeMake(self.width, kSectionHeight)
                                                                                                                                      itemSize:CGSizeMake(kItemWidth, kItemWidth)]];
        [self addSubview:(_latestCollection = latestCollection)];
    }
    return _latestCollection;
}

- (void)MeetingMembersCollectionSelectedMembers:(NSString *)delNameStr {
    [self.latestCollection syncDataMembersArrayWithIdentifier:delNameStr];
}

- (void)MeetingMembersCollectionContentHeight:(CGFloat)contentHeight {
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [self.membersCollection setHeight:contentHeight];
        [self.latestCollection setY:contentHeight];
        [self.latestCollection setHeight:self.height - contentHeight];
        
    } completion:nil];
}

- (void)MeetingMembersCollectionCurrentMembers:(NSInteger)currenMembers {
    [self.latestCollection syncCurrentNumbers:currenMembers];
}




- (void)LatestMembersCollectionDidSelectedMembers:(NSDictionary *)memberInfo {
    WCLog(@"The Member %@'s statu is %@", [[memberInfo allKeys] firstObject], [[memberInfo allValues] firstObject]);
    [self.membersCollection syncDataMembersArrayWithDic:memberInfo];
}
@end
///////////////////////////////////////////////////




#pragma mark - main class
@interface MeetingLuanchTableView()<UITableViewDelegate, UITableViewDataSource, ModifyViewDelegate>



@property (nonatomic, strong) NSMutableArray *dataItemArray;
@property (nonatomic, strong) NSMutableArray *dataContentArray;

@property (nonatomic, strong) TBFooterView *tbFooterView;
@property (nonatomic, strong) TBheaderView *tbheaderView;
@end


@implementation MeetingLuanchTableView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = WCClear;
        self.scrollEnabled = NO;
        self.delegate   = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableFooterView = self.tbFooterView;
    }
    return self;
}

- (TBFooterView *)tbFooterView {
    if (!_tbFooterView) {
        CGRect footerFrame = self.bounds;
        footerFrame.size.height -= 89;
        _tbFooterView = [[TBFooterView alloc] initWithFrame:footerFrame];
    }
    return _tbFooterView;
}

- (TBheaderView *)tbheaderView {
    if (!_tbheaderView) {
        CGRect frame = self.bounds;
        frame.size.height /= 2;
        _tbheaderView = [[TBheaderView alloc] initWithFrame:frame];
        _tbheaderView.image = [UIImage imageNamed:@"defaul_publishcover"];
    }
    return _tbheaderView;
}



- (NSMutableArray *)dataItemArray {
    if (!_dataItemArray) {
        _dataItemArray = [NSMutableArray arrayWithCapacity:0];
        [_dataItemArray addObjectsFromArray:@[@"会议主题", @"剩余分钟数"]];
    }
    return _dataItemArray;
}

- (NSMutableArray *)dataContentArray {
    if (!_dataContentArray) {
        _dataContentArray = [NSMutableArray arrayWithCapacity:0];
        [_dataContentArray addObjectsFromArray:@[@"木木的会议", @"600分钟"]];
    }
    return _dataContentArray;
}


#pragma mark - setter
- (void)setIsHiddenFooter:(BOOL)isHiddenFooter {
    _isHiddenFooter = isHiddenFooter;
    self.tableFooterView.hidden = isHiddenFooter;

    if (isHiddenFooter) {
        self.tableHeaderView = [self tbheaderView];
    }
}

- (void)setMaxMembers:(NSInteger)MaxMembers {
    _MaxMembers = MaxMembers;
    self.tbFooterView.membersCollection.totalNumbers = _MaxMembers;
    self.tbFooterView.latestCollection.totalNumbers  = _MaxMembers;
}




#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeetingLuanchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetingLuanchTableViewCellID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MeetingLuanchTableViewCell" owner:self options:nil] firstObject];
    }
    [cell configWithItem:self.dataItemArray[indexPath.row]
                 content:self.dataContentArray[indexPath.row]
               imageName:@""];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.isHiddenFooter)
        return [WCUIKitControl createViewWithFrame:CGRectZero BgColor:WCClear];
    else
        return [WCUIKitControl createViewWithFrame:CGRectZero BgColor:[UIColor colorWithRed:0.84 green:0.82 blue:0.79 alpha:1]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ModifyViewController *modifyVC = [[ModifyViewController alloc] init];
        modifyVC.isExitLeftItem = YES;
        modifyVC.headerTitle = self.dataItemArray[indexPath.row];
        modifyVC.originContent = self.dataContentArray[indexPath.row];
        modifyVC.modifyType = Modify_text;
        modifyVC.WCDelegate = self;
        [[AppDelegate sharedAppDelegate] pushViewController:modifyVC];
    }
}


#pragma mark - ModifyViewDelegate
- (void)modifyViewMofifyInfo:(NSDictionary *)modifyInfo {
    if ([[[modifyInfo allKeys] firstObject] isEqualToString:@"text"]) {
        [self.dataContentArray replaceObjectAtIndex:0 withObject:[modifyInfo objectForKey:@"text"]];
    }
    
    [self reloadData];
}


@end
