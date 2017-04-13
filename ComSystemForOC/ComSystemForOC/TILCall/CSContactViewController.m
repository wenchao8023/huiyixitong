//
//  CSContactViewController.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/5.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSContactViewController.h"

#import "CSFriendsCell.h"

#import "SelectedContactVC.h"


@interface CSContactViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *selectLabel;

@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, nonnull, strong) NSMutableArray *dataArray;

@property (nonatomic, nonnull, strong) NSMutableArray *statuArray;

@property (nonatomic, strong, nullable) NSMutableArray *selectArray;

@property (nonatomic, copy, nullable) NSString *nickName;



@end

@implementation CSContactViewController

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

-(void)craeteUI {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)loadData {
    
    self.nickName = [CommonUtil getUserID];
    
    [self.dataArray addObjectsFromArray:@[@"Aaaaaaaa", @"Bbbbbbbb", @"Cccccccc", @"Dddddddd", @"Eee", @"F", @"Gg"]];
    
    for (NSString *nameStr in self.dataArray) {
        if ([nameStr isEqualToString:self.nickName]) {    //刚进来的时候，只有自己是选择的，如果是快速开始就不是的，这里要根据需求设计
            [self.statuArray addObject:@"1"];
        } else {
            [self.statuArray addObject:@"0"];
        }
    }
}

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
-(NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _selectArray;
}




#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //在 storyBoard 中已经创建了 cell，所以可以直接用了
    CSFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSFriendsCell"];
    
    if ([self.statuArray[indexPath.row] isEqualToString:@"1"]) {
        [cell configWithSelected:self.dataArray[indexPath.row]];
    } else {
        [cell configWithUnSelected:self.dataArray[indexPath.row]];
    }
    
    if ([self.dataArray[indexPath.row] isEqualToString:self.nickName]) {
        cell.userInteractionEnabled = NO;
        [cell configSelf:self.dataArray[indexPath.row]];
    }
    
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
    
    self.selectLabel.text = [NSString stringWithFormat:@"已选择：%lu人", self.selectArray.count];
    
    self.confirmLabel.text = [NSString stringWithFormat:@"确定(%lu/15)", self.selectArray.count];
}

- (void)setSelected {
    
    [self.selectArray removeAllObjects];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        if ([self.statuArray[i] isEqualToString:@"1"]) {
            
            if ([self.dataArray[i] isEqualToString:self.nickName]) {
                continue ;
            }
            [self.selectArray addObject:self.dataArray[i]];
        }
    }
}



//- (IBAction)clickSelected:(id)sender {
//    
//    NSLog(@"已选择");
//    [self performSegueWithIdentifier:@"showSelectedContact" sender:self];
//}
//
//- (IBAction)clickConfirm:(id)sender {
//    
//    NSLog(@"确认");
//}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    return self.selectArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"segue indentifier is : %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"FriendMakeCall"]) {
        
        UIViewController *destinationController = [segue destinationViewController];
        
            [destinationController setValue:@102
                                     forKey:@"_beginType"];
            [destinationController setValue:self.selectArray
                                     forKey:@"peerArray"];
    }
    
    if ([segue.identifier isEqualToString:@"showSelectedContact"]) {
        
        SelectedContactVC *destinationController = [segue destinationViewController];
//        SelectedContactVC *destinationController = [[UIStoryboard storyboardWithName:@"CSCall" bundle:nil] instantiateViewControllerWithIdentifier:@"SelectedContactVC"];
        
        [destinationController setValue:self.selectArray forKey:@"dataArray"];
        
        __weak typeof(&*self) sself = self;
        destinationController.quedingBlock = ^(NSArray *dataArr) {
            
            [sself setReSelectContact:dataArr];
            
        };
    }
}

- (void)setReSelectContact:(NSArray *)dataArr {
    
    for (int i = 0; i < self.statuArray.count; i++) {
        if ([self.dataArray[i] isEqualToString:self.nickName]) {
            continue ;
        }
        [self.statuArray replaceObjectAtIndex:i withObject:@"0"];
    }
    
    for (NSString *nameStr in dataArr) {
        NSUInteger index = [self.dataArray indexOfObject:nameStr];
        [self.statuArray replaceObjectAtIndex:index withObject:@"1"];
    }
    
    [self.tableView reloadData];
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
