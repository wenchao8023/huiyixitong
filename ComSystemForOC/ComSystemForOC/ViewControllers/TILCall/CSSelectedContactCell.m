//
//  CSSelectedContactCell.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/10.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSSelectedContactCell.h"

@interface CSSelectedContactCell ()

@property (weak, nonatomic) IBOutlet UILabel *iconLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CSSelectedContactCell

-(void)config:(NSString *)str {
    
    self.iconLabel.text = [self getIconLabelStr:str];
    
    self.nameLabel.text = str;
}

-(NSString *)getIconLabelStr:(NSString *)str {
    
    if (str.length <= 2) {
        return str;
        
    } else if (str.length <=3) {
        return [str substringFromIndex:1];
        
    } else if (str.length <= 4) {
        return [str substringFromIndex:2];
        
    } else {
        return [str substringToIndex:1];
    }
}

- (IBAction)delClicke:(id)sender {
    self.delBlock();
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
