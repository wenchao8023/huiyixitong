//
//  CSFriendsCell.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/5.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSFriendsCell.h"


@interface CSFriendsCell ()

@property (weak, nonatomic) IBOutlet UIView *selectView;

@property (weak, nonatomic) IBOutlet UILabel *iconLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end


@implementation CSFriendsCell

-(void)configWithSelected:(NSString *)nameStr {
    
    self.selectView.backgroundColor = [UIColor blueColor];
    
    self.selectView.layer.borderWidth = 0;
    
    self.iconLabel.text = [self getIconLabelStr:nameStr];
    
    self.nameLabel.text = nameStr;
}

-(void)configWithUnSelected:(NSString *)nameStr {
    
    self.selectView.backgroundColor = [UIColor whiteColor];
    
    self.selectView.layer.borderWidth = 1;
    
    self.selectView.layer.borderColor = [UIColor blueColor].CGColor;
    
    self.iconLabel.text = [self getIconLabelStr:nameStr];
    
    self.nameLabel.text = nameStr;
}

-(void)configSelf:(NSString *)nameStr {
 
    self.selectView.backgroundColor = [UIColor grayColor];
    
    self.selectView.layer.borderWidth = 0;
    
    self.iconLabel.text = [self getIconLabelStr:nameStr];
    
    self.iconLabel.backgroundColor = [UIColor grayColor];
    
    self.nameLabel.text = nameStr;
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
