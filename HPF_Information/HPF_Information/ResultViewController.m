//
//  ResultViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/9.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "ResultViewController.h"
#import "Bus.h"
#import "Station.h"
#import "TopView.h"
#import "Station.h"
#import "StationTableViewCell.h"
#import "FirstStationTableViewCell.h"
@interface ResultViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *busesArray;
@property(nonatomic,strong)NSMutableArray *stationArray;
@property(nonatomic,assign)BOOL flag;
@property(nonatomic,strong)UIAlertController *alert;
@property(nonatomic,strong)TopView *topView;
@property(nonatomic,strong)UITableView *tab;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"查询结果页面";
    [self selectResult];
    
    
}

-(void)selectResult
{
    [NetworkRequestManager requestWithType:POST urlString:@"http://apis.baidu.com/xiaota/bus_lines/buses_lines" ParDic:@{@"city":@"广州",@"bus":self.busNumber,@"direction":@"0"} Header:kBaiDuAPIKey finish:^(NSData *data) {
        
        [self.busesArray removeAllObjects];
        [self.stationArray removeAllObjects];
        
        NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic = [dicData objectForKey:@"data"];
        NSArray *array = [dic objectForKey:@"buses"];
        //            NSLog(@"%ld",array.count);
        for (NSDictionary *dic in array) {
            Bus *car = [[Bus alloc] init];
            car.busId = [dic objectForKey:@"busId"];
            car.station = [dic objectForKey:@"station"];
            car.state = [dic objectForKey:@"state"];
            car.reporTime = [dic objectForKey:@"reporTime"];
            [self.busesArray addObject:car];
            NSLog(@"%@",car.reporTime);
        }
        NSArray *arr = [dic objectForKey:@"stations"];
        //                NSLog(@"%ld",arr.count);
        for (NSDictionary *dic in arr) {
            Station *station = [[Station alloc] init];
            station.stateName = [dic objectForKey:@"stateName"];
            station.station = [dic objectForKey:@"station"];
            NSLog(@"%@",station.stateName);
            [self.stationArray addObject:station];
            
        }
        NSLog(@"------->%ld",_stationArray.count);
        //回归主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //判断,当数据错误,时候执行提示
            if (_stationArray.count == 0) {
                _alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"抱歉,暂无该车信息" preferredStyle:UIAlertControllerStyleAlert];
                
                [self presentViewController:_alert animated:YES completion:^{
                    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(reBack) userInfo:nil repeats:NO];
                }];
            }
            else{
#pragma -mark 避免刷新的时候重复 执行 self createContext
                if (!_flag) {
                    [self createUI];
                }
            }
        });
    } err:^(NSError *error) {
    
    }];
}
-(void)createUI
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tab];
}

#pragma mark- 懒加载
-(NSMutableArray *)busesArray
{
    if (!_busesArray) {
        _busesArray = [NSMutableArray array];
    }
    return _busesArray;
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
        _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT/11+5, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-49-kSCREEN_HEIGHT/11-5) style:UITableViewStylePlain];
        _tab.delegate = self;
        _tab.dataSource = self;
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        //透明度改变
        [_tab setOpaque:NO];
        _tab.backgroundColor = [UIColor clearColor];
    }
    return _tab;
}

-(TopView *)topView
{
    if (!_topView) {
        _topView = [[TopView alloc] init];
        _topView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT/11+5);
        _topView.layer.borderColor = [UIColor blackColor].CGColor;
        _topView.layer.borderWidth = 1;
        Station *startStation = [_stationArray objectAtIndex:0];
        Station *lastStation = [_stationArray lastObject];
        _topView.StartLabel.text = [NSString stringWithFormat:@"始发站:%@",startStation.stateName];
        _topView.FinalLabel.text =[NSString stringWithFormat:@"终点站:%@",lastStation.stateName];
        _topView.carTitleLabel.text = self.busNumber;
        [_topView.reloadButton addTarget:self action:@selector(reloadtable) forControlEvents:UIControlEventTouchDown];
    }
    return _topView;
}
#pragma -mark tableview 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_stationArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    static NSString *identifier1 = @"cell1";
    //判断起点站
    if (indexPath.row == 0) {
        FirstStationTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell1 == nil) {
            cell1 = [[[NSBundle mainBundle] loadNibNamed:@"FirstStationTableViewCell" owner:self options:nil] lastObject];
        }
        Station *station = [_stationArray objectAtIndex:indexPath.row];
        cell1.FirstStitionLabel.text = station.stateName;
        cell1.FirstStationImage.image = [UIImage imageNamed:@"start"];
        
        [cell1 setOpaque:NO];
        cell1.backgroundColor = [UIColor clearColor];
        return cell1;
        
    }else
    {
        StationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StationTableViewCell" owner:nil options:nil] lastObject];
            
        }
        Station *station = [_stationArray objectAtIndex:indexPath.row];
        //判断汽车是否已经入站,若已经入站就汽车变成红色,还没有就是绿色
        for (Bus *buses in _busesArray) {
            if ([station.station isEqual:buses.station]) {
                
                if (buses.state.intValue == 1) {
                    [cell.stopBusButton setImage:[UIImage imageNamed:@"redCar"]];
                    NSLog(@"11");
                }else{
                    [cell.runningBusButton setImage:[UIImage imageNamed:@"greenCar"]];
                }
            }
        }
        //判断站点是否为总站,若是就用终点图片
        if (indexPath.row == _stationArray.count-1) {
            cell.stationNumber.text = @"终";
            cell.stationNumber.backgroundColor = [UIColor orangeColor];
            cell.stationNumber.textColor = [UIColor whiteColor];
        }else{
            cell.stationNumber.text = [NSString stringWithFormat:@"%@",station.station];
        }
        //车站的名字
        cell.stationLabel.text = station.stateName;
        
        
        [cell setOpaque:NO];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 36;
    }else{
        return 80;
    }
    
}


#pragma makr- 按钮方法
-(void)reloadtable
{
    _flag = YES;
    [self selectResult];
}
-(void)reBack
{
    [_alert dismissViewControllerAnimated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
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
