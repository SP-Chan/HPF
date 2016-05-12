//
//  StationResultViewController.m
//  HPF_Information
//
         //  Created by XP on 16/5/10.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "StationResultViewController.h"
#import "BusStation.h"
#import "PassStationTableViewCell.h"
#import "LineResultViewController.h"

@interface StationResultViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)NSMutableArray *stationArray;
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)UIAlertController *alert;
@end

@implementation StationResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
}

-(void)requestData
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kBusCity];
    [NetworkRequestManager requestWithType:POST urlString:@"http://op.juhe.cn/189/bus/station" ParDic:@{@"city":string,@"station":self.busName,@"key":kJuHeAPIKey} Header:nil finish:^(NSData *data) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        //判断请求数据是否成功
        if ([[dic objectForKey:@"reason"] isEqualToString:@"success"]) {
            NSArray *array = [dic objectForKey:@"result"];
            
            for (NSDictionary *modelDic in array) {
                BusStation *station = [[BusStation alloc] init];
                [station setValuesForKeysWithDictionary:modelDic];
                [self.stationArray addObject:station];
//                NSLog(@"%@",station.name);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view addSubview:self.tab];
            });
        }else{
            _alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"抱歉,暂无该车信息" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:_alert animated:YES completion:^{
                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(reBack) userInfo:nil repeats:NO];
            }];

        }
        
    } err:^(NSError *error) {
    }];
}
-(void)reBack
{
    [_alert dismissViewControllerAnimated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
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
        _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-49-64) style:UITableViewStylePlain];
        _tab.delegate = self;
        _tab.dataSource = self;
    }
    return _tab;
}
#pragma  mark- tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stationArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    PassStationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PassStationTableViewCell" owner:self options:nil] lastObject];
    }
    BusStation *station = [self.stationArray objectAtIndex:indexPath.row];
    cell.busNumber.text = station.key_name;
    cell.frontName.text = station.front_name;
    cell.terminalName.text = station.terminal_name;
    cell.startTime.text = [NSString stringWithFormat:@"首: %@",[self AppendingNewTimeString:station.start_time]];
    cell.endTime.text = [NSString stringWithFormat:@"末: %@",[self AppendingNewTimeString:station.end_time]];
    
    cell.basePrice.text = [NSString stringWithFormat:@"基本票价%@元",[station.basic_price substringWithRange:NSMakeRange(0, 3)]];
    cell.totalPrice.text = [NSString stringWithFormat:@"全程票价%@元",[station.total_price substringWithRange:NSMakeRange(0, 3)]];
    
    
    cell.length.text = [NSString stringWithFormat:@"全程共%@公里",[station.length substringWithRange:NSMakeRange(0, 5)]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LineResultViewController *line = [[LineResultViewController alloc] init];
    BusStation *station = [self.stationArray objectAtIndex:indexPath.row];
    line.busNumber = station.name;
    [self.navigationController pushViewController:line animated:YES];
}
#pragma mark- 修改字符串样式
-(NSString *)AppendingNewTimeString:(NSString *)TimeString
{
    NSString *startString = [TimeString substringWithRange:NSMakeRange(0, 2)];
    NSString *endString = [TimeString substringWithRange:NSMakeRange(2, 2)];
    NSString *newString = [startString stringByAppendingString:@":"];
    NSString *appendingString = [newString stringByAppendingString:endString];
    return appendingString;
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
