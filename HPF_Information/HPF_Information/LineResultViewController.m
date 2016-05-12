//
//  LineResultViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/10.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "LineResultViewController.h"
#import "BusesLine.h"
#import "StationMessage.h"
#import "LineTopView.h"
#import "LineStartTableViewCell.h"
#import "LineStationTableViewCell.h"
@interface LineResultViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)BusesLine *forwardLine;
@property(nonatomic,strong)BusesLine *reverseLine;
@property(nonatomic,strong)NSMutableArray *forwardArray;
@property(nonatomic,strong)NSMutableArray *reverseArray;
@property(nonatomic,strong)LineTopView *lineTopView;
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSArray *changeArray;
@property(nonatomic,assign)BOOL isForward;
@property(nonatomic,strong)UIAlertController *alert;
@end

@implementation LineResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.isForward = YES;
    [self requestData];
    
    
}
-(void)createUI
{
    [self.view addSubview:self.lineTopView];
    [self.view addSubview:self.tab];
}


-(void)requestData
{
    [self.forwardArray removeAllObjects];
    [self.reverseArray removeAllObjects];
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kBusCity];
    [NetworkRequestManager requestWithType:POST urlString:@"http://op.juhe.cn/189/bus/busline" ParDic:@{@"city":string,@"bus":self.busNumber,@"key":kJuHeAPIKey} Header:nil finish:^(NSData *data) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *resultArray = [dic objectForKey:@"result"];
        if ([[dic objectForKey:@"reason"] isEqualToString:@"success"])
        {

        [self.forwardLine setValuesForKeysWithDictionary:[resultArray objectAtIndex:0]];
        [self.reverseLine setValuesForKeysWithDictionary:[resultArray objectAtIndex:1]];
        
        //获取正向和逆向的数据
        for (NSDictionary *dic in self.forwardLine.stationdes) {
            StationMessage *message = [[StationMessage alloc] init];
            [message setValuesForKeysWithDictionary:dic];
            [self.forwardArray addObject:message];
            NSLog(@"%@",message.name);
        }
        for (NSDictionary *dic in self.reverseLine.stationdes) {
            StationMessage *message = [[StationMessage alloc] init];
            [message setValuesForKeysWithDictionary:dic];
            [self.reverseArray addObject:message];
            NSLog(@"%@",message.name);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.forwardArray.count == 0) {
                    _alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"抱歉,暂无该车信息" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:_alert animated:YES completion:^{
                    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(reBack) userInfo:nil repeats:NO];
                }];
                }else{
                self.changeArray = self.forwardArray;
                [self createUI];
                }
                
            });
        }
        }else{
            _alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"抱歉,暂无该车信息" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:_alert animated:YES completion:^{
                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(reBack) userInfo:nil repeats:NO];
            }];
            
        }
        
    } err:^(NSError *error) {
        
        
    }];
}
#pragma mark- 懒加载
-(UITableView *)tab
{
    if (!_tab) {
        _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT/11+20, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-49-kSCREEN_HEIGHT/8) style:UITableViewStylePlain];
        _tab.delegate = self;
        _tab.dataSource = self;
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        //透明度改变
        [_tab setOpaque:NO];
        _tab.backgroundColor = [UIColor clearColor];
    }
    return _tab;
}

-(LineTopView *)lineTopView
{
    if (!_lineTopView) {
        _lineTopView = [[LineTopView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT/11+20)];
//        if (self.isForward == YES) {
            _lineTopView.startLabel.text = [NSString stringWithFormat:@"起:%@",self.forwardLine.front_name];
            _lineTopView.finishLabel.text = [NSString stringWithFormat:@"终:%@",self.forwardLine.terminal_name];
            _lineTopView.startTimeLabel.text = [NSString stringWithFormat:@"首班车:%@",[self AppendingNewTimeString:self.forwardLine.start_time]];
        
            _lineTopView.finishTimeLabel.text = [NSString stringWithFormat:@"末班车:%@",[self AppendingNewTimeString:self.forwardLine.end_time]];
        
//        }else
//        {
//            _lineTopView.startLabel.text = [NSString stringWithFormat:@"起:%@",self.reverseLine.front_name];
//            _lineTopView.finishLabel.text = [NSString stringWithFormat:@"终:%@",self.reverseLine.terminal_name];
//            _lineTopView.startTimeLabel.text = [NSString stringWithFormat:@"首班车:%@",self.reverseLine.start_time];
//            _lineTopView.finishTimeLabel.text = [NSString stringWithFormat:@"末班车:%@",self.reverseLine.end_time];
//        }
               //票价
        float money = [self.forwardLine.basic_price floatValue];
        _lineTopView.picketPrice.text = [NSString stringWithFormat:@"票价:%.1f元",money];
        [_lineTopView.changeButton addTarget:self action:@selector(changeDirection:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lineTopView;
}
-(NSString *)AppendingNewTimeString:(NSString *)TimeString
{
    NSString *startString = [TimeString substringWithRange:NSMakeRange(0, 2)];
    NSString *endString = [TimeString substringWithRange:NSMakeRange(2, 2)];
    NSString *newString = [startString stringByAppendingString:@":"];
    NSString *appendingString = [newString stringByAppendingString:endString];
    return appendingString;
}
-(NSMutableArray *)forwardArray
{
    if (!_forwardArray) {
        _forwardArray = [NSMutableArray array];
        
    }
    return _forwardArray;
}
-(NSMutableArray *)reverseArray
{
    if (!_reverseArray) {
        _reverseArray = [NSMutableArray array];
    }
    return _reverseArray;
}
-(BusesLine *)forwardLine
{
    if (!_forwardLine) {
        _forwardLine = [[BusesLine alloc] init];
    }
    return _forwardLine;
}
-(BusesLine *)reverseLine
{
    if (!_reverseLine) {
        _reverseLine = [[BusesLine alloc] init];
    }
    return _reverseLine;
}

#pragma -mark tableview 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_forwardArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    static NSString *identifier1 = @"cell1";
    //判断起点站
    if (indexPath.row == 0) {
        LineStartTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell1 == nil) {
            cell1 = [[[NSBundle mainBundle] loadNibNamed:@"LineStartTableViewCell" owner:self options:nil] lastObject];
        }
        StationMessage *message = [self.changeArray objectAtIndex:indexPath.row];
        cell1.stationNumber.text = @"起";
        cell1.stationName.text = message.name;
        
        [cell1 setOpaque:NO];
        cell1.backgroundColor = [UIColor clearColor];
        return cell1;
        
    }else
    {
        LineStationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LineStationTableViewCell" owner:nil options:nil] lastObject];
            
        }
        StationMessage *message = [self.changeArray objectAtIndex:indexPath.row];
        //判断站点是否为总站,若是就用终点图片
        if (indexPath.row == self.changeArray.count-1) {
            cell.stationNumberLabel.text = @"终";
            cell.stationNumberLabel.backgroundColor = [UIColor orangeColor];
            cell.stationNumberLabel.textColor = [UIColor whiteColor];
        }else{
            cell.stationNumberLabel.text = message.stationNum;
        }
        //车站的名字
        cell.stationLabel.text = message.name;
        
        
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
        return 45;
    }else{
        return 60;
    }
    
}
#pragma mark- 点击方法
-(void)changeDirection:(HPFBaseButton *)button
{
//    [self.lineTopView removeFromSuperview];
    if (self.isForward) {
//        [self.view addSubview:self.lineTopView];
        self.isForward = NO;
        self.changeArray = self.reverseArray;
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"反向" forState:UIControlStateNormal];
        [self.tab reloadData];
        
    }else{
//        [self.view addSubview:self.lineTopView];
        self.isForward = YES;
        self.changeArray = self.forwardArray;
        button.backgroundColor = [UIColor greenColor];
        [button setTitle:@"正向" forState:UIControlStateNormal];
        [self.tab reloadData];
    }
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
