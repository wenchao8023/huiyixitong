//
//  CSOrderCell.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/7.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSOrderCell.h"



@interface CSOrderCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end



@implementation CSOrderCell

-(void)config:(NSString *)titleStr {
    self.titleLabel.text = titleStr;
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
