//
//  LocalViewController.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/3.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "LocalViewController.h"
#import "NetworkRequestManager.h"
#import "MJRefresh.h"

typedef void(^block)();


@interface LocalViewController ()

@property(nonatomic,assign)BOOL isRefresh;
@property(nonatomic,assign) CGFloat contentOffsetY;
@property(nonatomic,retain)UILabel *headerLable;
@property(nonatomic,retain)UILabel *footerLable;


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
    _tabView.backgroundColor = [UIColor clearColor];
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
    cell.backgroundColor = [UIColor clearColor];
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


#pragma mark- scrollView只要滑动就会走该方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取额外的大小(scrollView可滚动的距离)
    CGFloat contentSizeH = scrollView.contentSize.height - self.tabV.frame.size.height;
    
    //上拉到底部的高度(scrollView当前Y向底部的位置)
    self.contentOffsetY = scrollView.contentOffset.y - contentSizeH;
    
    self.footerLable.frame = CGRectMake(0, self.tabV.frame.size.height+contentSizeH, CGRectGetWidth(self.view.frame), 50);
    
    [self.tabV addSubview:_footerLable];
    if(!self.isRefresh)
    {
        self.headerLable.text = @"下拉刷新";
        self.footerLable.text = @"上拉加载";
        if(scrollView.contentOffset.y <= -50){
            _headerLable.text = @"释放立即刷新";
        }
        
        if (self.contentOffsetY >= 50) {
            _footerLable.text = @"释放加载更多";
        }
    }
    
    
    
    
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ((scrollView.contentOffset.y <= -50 || _contentOffsetY >= 50) && !self.isRefresh)
    {
        
        self.isRefresh = YES;
        
        if (scrollView.contentOffset.y <= -50) {
            _headerLable.text = @"刷新中.......";
        }else if (self.contentOffsetY >= 50)
        {
            _footerLable.text = @"加载中......";
        }
        
        if(scrollView.contentOffset.y <= -50)
        {
            [UIView animateWithDuration:0.2 animations:^{
                //使刷新页面同在刷新位置的代码
                scrollView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
                //写网络请求的代码
                //code....
                
            } completion:^(BOOL finished) {
                [self requestEndWithBlock:^{
                    
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                        
                    } completion:^(BOOL finished) {
                        self.isRefresh = NO;
//                        [_dataArary removeAllObjects];
//                        [self addDataWithCount:20];
                        [_tabView reloadData];
                    }];
                }];
            }];
        }
        if(self.contentOffsetY >= 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                //让上提更多的视图停在UI中一段时间
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
                
            } completion:^(BOOL finished) {
                [self requestEndWithBlock:^{
                    [UIView animateWithDuration:0.3 animations:^{
                        
                    } completion:^(BOOL finished) {
                        self.isRefresh = NO;
//                        [self addDataWithCount:5];
                        [_footerLable removeFromSuperview];
                        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                        [_tabView reloadData];
                        
                    }];
                }];
            }];
        }
    }
    
}



-(void)requestEndWithBlock:(block)blocks
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(2);
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            blocks();
            
        });
    });
    
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
