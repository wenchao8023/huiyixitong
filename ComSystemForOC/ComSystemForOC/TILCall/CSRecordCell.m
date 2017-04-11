//
//  CSRecordCell.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/5.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSRecordCell.h"


@interface CSRecordCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *leadingLabel;

@property (weak, nonatomic) IBOutlet UILabel *numbersLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation CSRecordCell


-(void)config:(CSRecordModel *)model {
    
    self.leadingLabel.text = [NSString stringWithFormat:@"%@(%lu人)",model.leaderName, model.participants.count];
    
    self.timeLabel.text = model.startTime;
    
    self.numbersLabel.text = [model.participants componentsJoinedByString:@"、"];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
