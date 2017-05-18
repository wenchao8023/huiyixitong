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








///////////////////////////////////////////////////
@interface TBFooterView : UIView

@property (nonatomic, strong) LatestMembersCollection   *latestCollection;
@property (nonatomic, strong) MeetingMembersCollection  *membersCollection;

@end


@implementation TBFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.membersCollection];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(self.width, 40);
        layout.itemSize = CGSizeMake(self.width / 4, self.width / 4);
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        
        
        CGRect membersFrame = self.bounds;
        membersFrame.size.height = 40 + self.width / 4;
        self.membersCollection = [[MeetingMembersCollection alloc] initWithFrame:membersFrame collectionViewLayout:layout];
        [self addSubview:self.membersCollection];
        
        CGRect latestFrame = self.bounds;
        latestFrame.origin.y = CGRectGetMaxY(self.membersCollection.frame);
        latestFrame.size.height -= CGRectGetMaxY(self.membersCollection.frame);
        self.latestCollection = [[LatestMembersCollection alloc] initWithFrame:latestFrame collectionViewLayout:layout];
        [self addSubview:self.latestCollection];
    }
    return self;
}

@end
///////////////////////////////////////////////////





@interface MeetingLuanchTableView()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) MeetingMembersCollection *membersCollection;

@property (nonatomic, strong) NSMutableArray *dataItemArray;
@property (nonatomic, strong) NSMutableArray *dataContentArray;

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
//        self.tableFooterView = self.membersCollection;
        CGRect footerFrame = self.bounds;
        footerFrame.size.height -= 89;
        self.tableFooterView = [[TBFooterView alloc] initWithFrame:footerFrame];
    }
    return self;
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
- (void)setIsHiddenHeader:(BOOL)isHiddenHeader {
    _isHiddenHeader = isHiddenHeader;
    self.tableFooterView.hidden = isHiddenHeader;
}

- (void)setMaxMembers:(NSInteger)MaxMembers {
    _MaxMembers = MaxMembers;
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
    if (self.isHiddenHeader)
        return [WCUIKitControl createViewWithFrame:CGRectZero BgColor:WCClear];
    else
        return [WCUIKitControl createViewWithFrame:CGRectZero BgColor:[UIColor colorWithRed:0.84 green:0.82 blue:0.79 alpha:1]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
