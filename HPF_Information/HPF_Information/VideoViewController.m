//
//  VideoViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoTableViewCell.h"
#import "NetworkRequestManager.h"
#import "Video.h"
#import "activityView.h"
#import "WJRefresh.h"

@interface VideoViewController ()
@property(nonatomic,strong)NSMutableArray *DataArray;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)UIActivityIndicatorView *activity;
@property(nonatomic,assign)float mobileContentOffset;
@property (nonatomic,strong) WJRefresh *refresh;
@property(nonatomic,strong)activityView *activ;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:@"播放" object:nil];
    
    _count=10;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self RequestData];
        
    
       
            dispatch_async(dispatch_get_main_queue(), ^{
                
            [self setTableView];
                
            });
        
        
    });
    
    
    
    
    
  
   
    
}

-(void)notification:(NSNotification *)action
{
    
    NSDictionary *dic =action.userInfo;
    
    VideoPlayerViewController *vid = [[VideoPlayerViewController alloc]init];
    
    vid.MP4Url = [dic objectForKey:@"play"];
    vid.videoTitle = [dic objectForKey:@"title"];
    
    
    [self presentViewController:vid animated:YES completion:^{
        
    }];


}

-(void)RequestData
{

    
    NSString *url = [NSString stringWithFormat:@"http://napi.uc.cn/3/classes/topic/lists/发现视频列表?_app_id=hottopic&_size=%ld&_fetch=1",_count];

    
    [NetworkRequestManager requestWithType:GET urlString:url ParDic:nil Header:nil finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = [dic objectForKey:@"data"];
        
        
        _DataArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            
                Video *vi = [[Video alloc]init];
                [vi setValuesForKeysWithDictionary:dic];
                
                [_DataArray addObject:vi];
            
        }
       
        if (_DataArray.count>0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                
            });
            
        }
        
    } err:^(NSError *error) {
        
    }];
    
    

}

-(void)setTableView
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:_tableView];

    /* 初始化控件 */
    _refresh = [[WJRefresh alloc]init];
    __weak typeof(self)weakSelf = self;
    [_refresh addHeardRefreshTo:_tableView heardBlock:^{
        [weakSelf createData];
    } footBlok:^{
        [weakSelf createFootData];
    }];
    [_refresh beginHeardRefresh];

}
- (void)createData{
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _count=10;
        [self RequestData];
        [self.tableView reloadData];
        [_refresh endRefresh];
    });
    
}

- (void)createFootData{
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _count= _count+10;
    
        [self RequestData];
        [self.tableView reloadData];
        [_refresh endRefresh];
        
        
        
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *identifier=@"cell";
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Video *vi = [_DataArray objectAtIndex:indexPath.row];
    
    
    
    cell.video =vi;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10+(kSCREEN_WIDTH-20)/48 +(kSCREEN_WIDTH-60)/14 +20+((kSCREEN_WIDTH-60)*2/7+40+(kSCREEN_WIDTH-20)*2/3+10);

}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    ///配置 CATransform3D 动画内容
    CATransform3D  transform ;
    transform.m11 = 1.0/-400;
    //定义 Cell的初始化状态
    cell.layer.transform = transform;
    //定义Cell 最终状态 并且提交动画
    [UIView beginAnimations:@"transform" context:NULL];
    [UIView setAnimationDuration:1];
    cell.layer.transform = CATransform3DIdentity;
    cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView commitAnimations];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//_mobileContentOffset =scrollView.contentOffset.y;
//     CGFloat contentSizeH = scrollView.contentSize.height - self.tableView.frame.size.height;
//    
//    NSLog(@"SizeH ======>>> %f",contentSizeH);
//    //上拉到底部的高度
//    NSLog(@"contentSizeH = %f",scrollView.contentSize.height);
//    //上拉到底部的高度
//
//}



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
