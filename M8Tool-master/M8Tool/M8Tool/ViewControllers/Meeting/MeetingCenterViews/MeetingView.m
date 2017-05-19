//
//  MeetingView.m
//  M8Tool
//
//  Created by chao on 2017/5/15.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "MeetingView.h"

#import "MeetingAgendaCollection.h"
#import "MeetingButtonsCollection.h"





/////////////////////////////////////////////////
/**
 添加 ‘会议议程’ 标题，和 ‘更多’ 按钮
 */
@interface AgendaHeaderView : UICollectionReusableView

@end


@implementation AgendaHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createHeaderUI];
    }
    return self;
}

- (void)createHeaderUI {
    UILabel *titleLabel = [WCUIKitControl createLabelWithFrame:CGRectMake(20, 0, 80, self.height)
                                                          Text:@"会议议程"
                                                      FontSize:kAppMiddleFontSize
                                                       BgColor:WCClear
                           ];
    [self addSubview:titleLabel];
    
    UIButton *moreButton = [WCUIKitControl createButtonWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 60, self.height)
                                                       ImageName:@""
                                                          Target:self
                                                          Action:@selector(moreAgendaAction)
                                                           Title:@"更多"
                            ];
    [self addSubview:moreButton];
}

- (void)moreAgendaAction {
    WCLog(@"点击去更多会议议程");
}

@end
/////////////////////////////////////////////////


@interface MeetingView ()<AgendaCollectionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView                *bannerImage;

@property (weak, nonatomic) IBOutlet MeetingAgendaCollection    *agendaCollection;
@property (weak, nonatomic) IBOutlet MeetingButtonsCollection   *buttonsCollection;
@property (weak, nonatomic) IBOutlet UIPageControl              *pageControl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint         *agendaCollectionHeight;

@end


@implementation MeetingView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.agendaCollectionHeight.constant = SCREEN_WIDTH / 5 + 15;
    
    self.agendaCollection.agendaDelegate = self;
    
    self.pageControl.pageIndicatorTintColor = WCLightGray;
    self.pageControl.currentPageIndicatorTintColor = WCWhite;
}

- (MeetingAgendaCollection *)agendaCollection {
    if (!_agendaCollection) {
        
    }
    return _agendaCollection;
}

- (MeetingButtonsCollection *)buttonsCollection {
    if (!_buttonsCollection) {
        
    }
    return _buttonsCollection;
}

- (IBAction)moreAgendaAction:(id)sender {
    WCLog(@"更多会议议程");
}



#pragma mark - AgendaCollectionDelegate
- (void)AgendaCollectionNumberPage:(int)pageNumber {
    WCLog(@"numberOfPages is : %d", pageNumber);
    self.pageControl.numberOfPages = pageNumber;
    [self.pageControl setWidth:20 * pageNumber];
}

- (void)AgendaCollectionCurrentPage:(int)pageIndex {
    WCLog(@"pageIndex is : %d", pageIndex);
    self.pageControl.currentPage = pageIndex;
}


@end
