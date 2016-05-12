//
//  ChangeCityViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/12.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "ChangeCityViewController.h"

@interface ChangeCityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)UIAlertController *alert;
@end

@implementation ChangeCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kBusCity];
    self.navigationItem.title = [NSString stringWithFormat:@"当前选择城市:%@",string];
    [self.view addSubview:self.tab];
    
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
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"广州",@"佛山",@"东莞",@"重庆",@"苏州",@"成都",@"常州",@"杭州",@"上海",@"北京",@"武汉", nil];
    }
    return _dataArray;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [self.dataArray objectAtIndex:indexPath.row];
    _alert = [UIAlertController alertControllerWithTitle:@"切换至当前城市:" message:string preferredStyle:UIAlertControllerStyleAlert];
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:kBusCity];
    [self presentViewController:_alert animated:YES completion:^{
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reBack) userInfo:nil repeats:NO];
    }];
}
-(void)reBack
{
    [_alert dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCity" object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
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
