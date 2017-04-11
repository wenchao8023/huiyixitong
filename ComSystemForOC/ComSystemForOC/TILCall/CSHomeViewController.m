//
//  CSHomeViewController.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/5.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSHomeViewController.h"

#import "CSRecordCell.h"





@interface CSHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, nonnull, strong) NSMutableArray *dataArray;

@end

@implementation CSHomeViewController

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
    
    CSRecordModel *model = [CSRecordModel new];
    model.leaderName = @"我";
    model.startTime = @"下午03:37";
    model.participants = @[@"郭文超", @"林瑞", @"于佳", @"华仔", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model];
    
    CSRecordModel *model1 = [CSRecordModel new];
    model1.leaderName = @"我";
    model1.startTime = @"下午03:26";
    model1.participants = @[@"郭文超", @"林瑞", @"于佳"];
    [self.dataArray addObject:model1];
    
    CSRecordModel *model2 = [CSRecordModel new];
    model2.leaderName = @"我";
    model2.startTime = @"上午11:47";
    model2.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model2];
    
    CSRecordModel *model3 = [CSRecordModel new];
    model3.leaderName = @"我";
    model3.startTime = @"上午11:39";
    model3.participants = @[@"郭文超", @"林瑞"];
    [self.dataArray addObject:model3];
    
    CSRecordModel *model4 = [CSRecordModel new];
    model4.leaderName = @"我";
    model4.startTime = @"上午11:35";
    model4.participants = @[@"郭文超", @"林瑞", @"王路", @"贾磊"];
    [self.dataArray addObject:model4];
    
    CSRecordModel *model5 = [CSRecordModel new];
    model5.leaderName = @"我";
    model5.startTime = @"2017/3/28";
    model5.participants = @[@"郭文超", @"王路", @"贾磊"];
    [self.dataArray addObject:model5];
    
    CSRecordModel *model6 = [CSRecordModel new];
    model6.leaderName = @"我";
    model6.startTime = @"2017/3/2";
    model6.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model6];
   
    CSRecordModel *model7 = [CSRecordModel new];
    model7.leaderName = @"我";
    model7.startTime = @"2017/3/2";
    model7.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model7];
    
    CSRecordModel *model8 = [CSRecordModel new];
    model8.leaderName = @"我";
    model8.startTime = @"2017/3/2";
    model8.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model8];
    
    CSRecordModel *model9 = [CSRecordModel new];
    model9.leaderName = @"我";
    model9.startTime = @"2017/3/2";
    model9.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model9];
    
    CSRecordModel *model10 = [CSRecordModel new];
    model10.leaderName = @"我";
    model10.startTime = @"2017/3/2";
    model10.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model10];
    
    CSRecordModel *model11 = [CSRecordModel new];
    model11.leaderName = @"我";
    model11.startTime = @"2017/3/2";
    model11.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model11];
    
    CSRecordModel *model12 = [CSRecordModel new];
    model12.leaderName = @"我";
    model12.startTime = @"2017/3/2";
    model12.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model12];
    
    CSRecordModel *model13 = [CSRecordModel new];
    model13.leaderName = @"我";
    model13.startTime = @"2017/3/2";
    model13.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model13];
    
    CSRecordModel *model14 = [CSRecordModel new];
    model14.leaderName = @"我";
    model14.startTime = @"2017/3/2";
    model14.participants = @[@"郭文超", @"鲁三三", @"王路", @"贾磊"];
    [self.dataArray addObject:model14];
    
    [self.tableView reloadData];
    
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //在 storyBoard 中已经创建了 cell，所以可以直接用了
    CSRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSRecordCell"];

    [cell config:self.dataArray[indexPath.row]];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [self performSegueWithIdentifier:@"quickBeginCom" sender:self];
//    CSQuickBeginViewController *vc = [[CSQuickBeginViewController alloc] init];
//    [[AppDelegate sharedAppDelegate] pushViewController:vc];
}


- (IBAction)backHomeFromSegue:(UIStoryboardSegue *)unwindSegue {
    
    NSLog(@"back form %@", NSStringFromClass([unwindSegue.sourceViewController class]));
}


- (IBAction)beginClick:(id)sender {
    
    NSLog(@"马上开会");

}
- (IBAction)reserveClick:(id)sender {
    NSLog(@"预约开会");

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
