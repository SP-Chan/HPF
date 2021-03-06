//
//  HistoryViewController.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HistoryViewController.h"
#import "NetworkRequestManager.h"
#import "MJRefresh.h"
#import "MJRefreshAutoFooter.h"
#import "ThreeImageCell.h"
#import "ScrollViewController.h"
@interface HistoryViewController ()
{
    NSInteger startNum;//第几条开始加载;
    NSInteger countNum;//加载的数量;
}

@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)NSMutableArray *dataArrary;
@property(nonatomic,assign)NSInteger flag;

@end

@implementation HistoryViewController

#pragma mark 懒加载
-(NSMutableArray *)array
{
    if (!_array) {
        self.array = [NSMutableArray array];
    }
    return _array;
}

-(NSMutableArray *)dataArrary
{
    if (!_dataArrary) {
        self.dataArrary = [NSMutableArray array];
        
    }
    return _dataArrary;
}


#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    startNum = 0;
    countNum = 20;
    
    NSString *str = [NSString stringWithFormat:@"%ld-%ld",(long)startNum,countNum];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1368497029546/%@.html",str];
    
    [self requestData:urlStr];
    [self createTableView];
    
    [self creatFooterRefresh];
    [self creatHeaderRefresh];
    
    _flag = 0;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    if (_flag == 0) {
        // 马上进入刷新状态
        [self.tabView.mj_header beginRefreshing];
    }
    else
    {
        
    }
    _flag += 1;
}


#pragma mark 网络请求
-(void)requestData:(NSString *)string
{
    
    [NetworkRequestManager requestWithType:GET urlString:string ParDic:nil Header:nil finish:^(NSData *data) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *array = [dataDic objectForKey:@"T1368497029546"];
            for (NSDictionary *dic in array) {
                NewsModel *news = [[NewsModel alloc]init];
                [news setValuesForKeysWithDictionary:dic];
                [self.dataArrary addObject:news];
               
            }
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabView reloadData];
        });
        
        
        
        
    } err:^(NSError *error) {
        
    }];
}


#pragma mark 创建TableView
-(void)createTableView
{
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-35-110) style:UITableViewStylePlain];
    _tabView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tabView];
    
    _tabView.delegate = self;
    _tabView.dataSource = self;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArrary.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"%@",_news.imgextra);
    
    NewsModel *news = [[NewsModel alloc]init];
    
    news = [_dataArrary objectAtIndex:indexPath.row];
    
    if (news.imgextra != nil)
    {
        static NSString *identifier = @"cell";
        ThreeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ThreeImageCell" owner:nil options:nil]lastObject];
        }
        
        NewsModel *news = [[NewsModel alloc]init];
        
        news = [_dataArrary objectAtIndex:indexPath.row];
        cell.news = news;
        
        //        NSLog(@"%ld",news.imgextra.count);
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
        
    }
    else
    {
        static NSString *identifier = @"cell";
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CommonCell" owner:nil options:nil]lastObject];
        }
        
        NewsModel *news = [[NewsModel alloc]init];
        news = [_dataArrary objectAtIndex:indexPath.row];
        cell.news = news;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NewsModel *news = [[NewsModel alloc]init];
    
    news = [_dataArrary objectAtIndex:indexPath.row];
    
    if (news.imgextra != nil)
    {
        
        return 150;
    }
    else
    {
        return 120;
    }
    
    
    
}


#pragma mark  点击跳转的方法;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    NewsModel *news = [[NewsModel alloc]init];
    
    news = [_dataArrary objectAtIndex:indexPath.row];
    
    if (news.imgextra != nil)
    {
        ScrollViewController *sv = [[ScrollViewController alloc]init];
        sv.news = news;
        [self.navigationController pushViewController:sv animated:YES];
        
    }
    if (news.imgextra == nil)
    {
        
        WebViewController *webVC = [[WebViewController alloc]init];
        webVC.news = news;
        
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark  加载更多
- (void) creatFooterRefresh
{
    _tabView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


-(void)loadMoreData
{
    
    //  http://c.3g.163.com/nc/article/local/广州/0-20.html
    
    startNum = startNum +19;
    NSString *str = [NSString stringWithFormat:@"%ld-%ld",(long)startNum,countNum];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1368497029546/%@.html",str];
    
    [self requestData:urlStr];
    [self.tabView reloadData];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeStopP) userInfo:nil repeats:NO];
}


-(void)timeStopP
{
    [self.tabView.mj_footer endRefreshing];
}

//下拉刷新
-(void)creatHeaderRefresh
{
    _tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

-(void)loadNewData
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1368497029546/0-20.html"];
    
    [self requestData:urlStr];
    [_tabView  reloadData];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeStopPP) userInfo:nil repeats:NO];
}

-(void)timeStopPP
{
    [_tabView.mj_header endRefreshing];
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
