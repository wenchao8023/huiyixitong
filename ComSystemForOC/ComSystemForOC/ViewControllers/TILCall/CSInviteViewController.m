//
//  CSInviteViewController.m
//  ComSystemForOC
//
//  Created by 郭文超 on 2017/4/21.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSInviteViewController.h"

#import "CSFriendsCell.h"

@interface CSInviteViewController ()

@property (weak, nonatomic) IBOutlet UILabel *addButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, nonnull, strong) NSMutableArray *dataArray;
@property (nonatomic, nonnull, strong) NSMutableArray *statuArray;
@property (nonatomic, strong, nullable) NSMutableArray *selectArray;

@property (nonatomic, copy, nullable) NSString *nickName;

@end

@implementation CSInviteViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setButtons];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self craeteUI];
    
    [self loadData];
}

#pragma mark - init container
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}
-(NSMutableArray *)statuArray {
    if (!_statuArray) {
        _statuArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _statuArray;
}
// 只包含在这个界面新加进来的数据
-(NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _selectArray;
}

#pragma mark - createUI
-(void)craeteUI {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
}
#pragma mark - loadData
-(void)loadData {
    
    self.nickName = [CommonUtil getUserID];
    
    [self.dataArray addObjectsFromArray:@[@"Aaaaaaaa", @"Bbbbbbbb", @"Cccccccc", @"Dddddddd", @"Eee", @"F", @"Gg", @"RNG"]];
    
    for (NSString *nameStr in self.dataArray) {
        if ([self.inviteMoreArray containsObject:nameStr]) {
            [self.statuArray addObject:@"1"];
        } else {
            [self.statuArray addObject:@"0"];
        }
    }
}

#pragma mark - 添加
- (IBAction)addClick:(id)sender {
    
    self.inviteBlock(self.selectArray);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //在 storyBoard 中已经创建了 cell，所以可以直接用了
    CSFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSFriendsCell"];
    
    NSString *nameStr = self.dataArray[indexPath.row];
    
    if ([self.statuArray[indexPath.row] isEqualToString:@"1"]) {
        
        if ([self.dataArray[indexPath.row] isEqualToString:self.nickName])
        {
            cell.userInteractionEnabled = NO;
            [cell configSelf:self.dataArray[indexPath.row]];
        }
        else if ([self.inviteMoreArray containsObject:nameStr])
        {
            [cell invitedConfig:nameStr];
            cell.userInteractionEnabled = NO;
        }
        else
        {
            [cell configWithSelected:nameStr];
        }
        
    } else {
        [cell configWithUnSelected:nameStr];
    }
    
//    if ([self.inviteMoreArray containsObject:nameStr]) {
//        [cell invitedConfig:nameStr];
//        cell.userInteractionEnabled = NO;
//    }
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.row;
    
    if ([self.statuArray[index] isEqualToString:@"1"]) {
        
        [self.statuArray replaceObjectAtIndex:index withObject:@"0"];
        
        [self setButtons];
        
    } else {
        
        [self.statuArray replaceObjectAtIndex:index withObject:@"1"];
        
        [self setButtons];
    }
    
    [self.tableView reloadData];
}


-(void)setButtons {
    
    [self setSelected];
    
    int selectNum = (int)self.selectArray.count;
    int ableAddNum = (int)(16 - self.inviteMoreArray.count);
    
    self.navigationItem.title = [NSString stringWithFormat:@"选择%d/%d个人添加到会议", selectNum, ableAddNum];
    
    self.addButton.text = [NSString stringWithFormat:@"确定(%d/%d)", selectNum, ableAddNum];
}

- (void)setSelected {
    
    [self.selectArray removeAllObjects];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        if ([self.statuArray[i] isEqualToString:@"1"]) {
            
            if ([self.inviteMoreArray containsObject:self.dataArray[i]]) {
                continue ;
            }
            [self.selectArray addObject:self.dataArray[i]];
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
