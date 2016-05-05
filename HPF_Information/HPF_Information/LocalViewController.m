//
//  LocalViewController.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/3.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "LocalViewController.h"
#import "NetworkRequestManager.h"

@interface LocalViewController ()

@end

@implementation LocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    [self requestDatarequestWithType:GET UrlString:@"http://c.3g.163.com/nc/article/local/5bm%2F5bee/0-20.html" ParDic:nil Header:nil];
    
    
    [self createTableView];
    [self requestData];
    
    
    
    // Do any additional setup after loading the view.
}



-(void)requestData
{
    NSInteger startNum = 0;
    NSInteger countNum = 20;
    
    NSString *str = [NSString stringWithFormat:@"%ld-%ld",startNum,countNum];
    
   NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/local/广州/%@.html",str];
    
    
    [NetworkRequestManager requestWithType:GET urlString:urlStr ParDic:nil Header:nil finish:^(NSData *data) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            _dataArary = [NSMutableArray array];
            NSArray *array = [dataDic objectForKey:@"广州"];
            for (NSDictionary *dic in array) {
                NewsModel *news = [[NewsModel alloc]init];
                [news setValuesForKeysWithDictionary:dic];
                [_dataArary addObject:news];
            }
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
        
        
        
    } err:^(NSError *error) {
        
    }];
}



-(void)createTableView
{
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-35-110) style:UITableViewStylePlain];
    
    [self.view addSubview:_tabView];
    
    _tabView.delegate = self;
    _tabView.dataSource = self;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommonCell" owner:nil options:nil]lastObject];
    }
    
    NewsModel *news = [[NewsModel alloc]init];
    news = [_dataArary objectAtIndex:indexPath.row];
    cell.news = news;
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}




//点击跳转的方法;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsModel *news = [_dataArary objectAtIndex:indexPath.row];
    
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.news = news;
    
    [self.navigationController pushViewController:webVC animated:YES];
    
    
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
