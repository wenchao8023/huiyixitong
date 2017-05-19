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


#pragma mark - CSContactViewController 界面数据 config

/**
 * 给选中的成员设置状态
 * 背景： blue，
 * 边框： none

 @param nameStr 选中成员名
 */
-(void)configWithSelected:(NSString *)nameStr {
    
    self.selectView.backgroundColor = [UIColor blueColor];
    self.selectView.layer.borderWidth = 0;
    
    self.iconLabel.text = [self getIconLabelStr:nameStr];
    
    self.nameLabel.text = nameStr;
}

/**
 * 给没有选中的成员设置状态
 * 背景： white，
 * 边框： 1，blue
 
 @param nameStr 选中成员名
 */
-(void)configWithUnSelected:(NSString *)nameStr {
    
    self.selectView.backgroundColor = [UIColor whiteColor];
    self.selectView.layer.borderWidth = 1;
    self.selectView.layer.borderColor = [UIColor blueColor].CGColor;
    
    self.iconLabel.text = [self getIconLabelStr:nameStr];
    
    self.nameLabel.text = nameStr;
}

/**
 * 给自己设置状态
 * 背景： lightGray，
 * 边框： none
 
 @param nameStr 选中成员名
 */
-(void)configSelf:(NSString *)nameStr {
 
    self.selectView.backgroundColor = [UIColor lightGrayColor];
    self.selectView.layer.borderWidth = 0;
    
    self.iconLabel.text = [self getIconLabelStr:nameStr];
    self.iconLabel.backgroundColor = [UIColor lightGrayColor];
    
    self.nameLabel.text = nameStr;
}

#pragma mark - CSInviteViewController 界面数据 config

/**
 * 给已经被选中的赋值
 * 背景： darkGray，
 * 边框： none
 
 @param nameStr 选中成员名
 */
- (void)invitedConfig:(NSString *)nameStr {
    
    self.selectView.backgroundColor = [UIColor darkGrayColor];
    self.selectView.layer.borderWidth = 0;
    
    self.iconLabel.text = [self getIconLabelStr:nameStr];
    self.iconLabel.backgroundColor = [UIColor darkGrayColor];
    
    self.nameLabel.text = nameStr;
}

/**
 * 给在这个界面中被选中的赋值
 * 背景： blue，
 * 边框： none
 
 @param nameStr 选中成员名
 */
//- (void)inviteMoreConfig:(NSString *)nameStr {
//    
//    self.selectView.backgroundColor = [UIColor blueColor];
//    self.selectView.layer.borderWidth = 0;
//    
//    self.iconLabel.text = [self getIconLabelStr:nameStr];
//    
//    self.nameLabel.text = nameStr;
//}

///**
// * 给在这个界面中取消选中的赋值
// * 背景： darkGray，
// * 边框： none
// 
// @param nameStr 选中成员名
// */
//- (void)unInviteMoreConfig:(NSString *)nameStr {
//    
//    self.selectView.backgroundColor = [UIColor darkGrayColor];
//    self.selectView.layer.borderWidth = 0;
//    
//    self.iconLabel.text = [self getIconLabelStr:nameStr];
//    self.iconLabel.backgroundColor = [UIColor grayColor];
//    
//    self.nameLabel.text = nameStr;
//}

#pragma mark - -

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
