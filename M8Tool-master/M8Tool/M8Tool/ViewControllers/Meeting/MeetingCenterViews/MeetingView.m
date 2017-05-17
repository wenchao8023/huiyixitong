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
    
    self.agendaCollectionHeight.constant = SCREEN_WIDTH / 5 + 20;
    
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
