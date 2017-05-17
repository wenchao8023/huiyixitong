//
//  MeetingLuanchTableView.m
//  M8Tool
//
//  Created by chao on 2017/5/17.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "MeetingLuanchTableView.h"
#import "MeetingMembersCollection.h"


@interface MeetingLuanchTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MeetingMembersCollection *membersCollection;

@end



@implementation MeetingLuanchTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = WCClear;
        self.scrollEnabled = NO;
        self.delegate   = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = self.membersCollection;
    }
    return self;
}

- (MeetingMembersCollection *)membersCollection {
    if (!_membersCollection) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        MeetingMembersCollection *membersCollection = [[MeetingMembersCollection alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        membersCollection.height = 100;
        [self addSubview:(_membersCollection = membersCollection)];
    }
    return _membersCollection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellidddddddd"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellidddddddd"];
        [cell.textLabel setAttributedText:[CommonUtil customAttString:@"会议选项"
                                                             fontSize:kAppMiddleFontSize
                                                            textColor:WCBlack
                                                            charSpace:kAppKern_2]
         ];
        cell.backgroundColor = WCClear;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WCLog(@"");
}

@end
