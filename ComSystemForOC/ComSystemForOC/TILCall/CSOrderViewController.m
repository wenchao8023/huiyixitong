//
//  CSOrderViewController.m
//  ComSystemForOC
//
//  Created by chao on 2017/4/5.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "CSOrderViewController.h"

#import "CSOrderCell.h"




@interface CSOrderViewController ()<UITableViewDelegate, UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong, nonnull) NSMutableArray *dataArray;




@end

@implementation CSOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)createUI {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    
    [self.dataArray addObjectsFromArray:@[@"会议主题", @"开始时间", @"预估时长"]];
}

-(NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}








-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CSOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSOrderCell" forIndexPath:indexPath];
    
    
    
    return cell;
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
