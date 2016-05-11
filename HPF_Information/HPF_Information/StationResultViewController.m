//
//  StationResultViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/10.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "StationResultViewController.h"
#import "BusStation.h"
@interface StationResultViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *stationArray;
@property(nonatomic,strong)UITableView *tab;
@end

@implementation StationResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
}

-(void)requestData
{
    [NetworkRequestManager requestWithType:POST urlString:@"http://op.juhe.cn/189/bus/station" ParDic:@{@"city":@"广州",@"station":@"上元岗",@"key":kJuHeAPIKey} Header:nil finish:^(NSData *data) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if ([[dic objectForKey:@"reason"] isEqualToString:@"success"]) {
            NSArray *array = [dic objectForKey:@"result"];
            
            for (NSDictionary *modelDic in array) {
                BusStation *station = [[BusStation alloc] init];
                [station setValuesForKeysWithDictionary:modelDic];
                [self.stationArray addObject:station];
                NSLog(@"%@",station.name);
            }
        
        }
   
    } err:^(NSError *error) {
    }];
}

-(NSMutableArray *)stationArray
{
    if (!_stationArray) {
        _stationArray = [NSMutableArray array];
    }
    return _stationArray;
}
-(UITableView *)tab
{
    if (!_tab) {
        _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tab.delegate = self;
        _tab.dataSource = self;
    }
    return _tab;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
