//
//  MeetingAgendaCell.m
//  M8Tool
//
//  Created by chao on 2017/5/15.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "MeetingAgendaCell.h"

@interface MeetingAgendaCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation MeetingAgendaCell

- (void)configWithTitle:(NSString *)title imageStr:(NSString *)imageStr {
    [self.timeLabel setAttributedText:[CommonUtil customAttString:title
                                                          fontSize:kAppMiddleFontSize
                                                         textColor:WCWhite
                                                         charSpace:kAppKern_0]
     ];
//    self.iconImage.image = [UIImage imageNamed:imageStr];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
