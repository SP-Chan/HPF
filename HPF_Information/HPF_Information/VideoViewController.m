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
#import "RecordDataBase.h"
#import "VideoRecordViewController.h"
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
    
   
    
    [[RecordDataBase shareRecordData]createTabe];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:@"播放" object:nil];
    
    _count=10;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self RequestData];
        
    
       
            dispatch_async(dispatch_get_main_queue(), ^{
                
            [self setTableView];
                
            });
        
        
    });
    
    
    
    [self setRightBarButtonItem];
    
}
-(void)setRightBarButtonItem
{

    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"jilu.png"]forState:UIControlStateNormal];
  
    [rightButton addTarget:self action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem= rightItem;
    self.navigationItem.title=@"视频短片";

}

-(void)record
{
    VideoRecordViewController *video = [[VideoRecordViewController alloc]init];
    [self.navigationController pushViewController:video animated:YES];
    
    
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

    
    NSString *url = [NSString stringWithFormat:@"http://napi.uc.cn/3/classes/topic/lists/发现视频列表?_app_id=hottopic&_size=%d&_fetch=1",_count];

    
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
    self.tableView.backgroundColor = [UIColor clearColor];
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
    cell.backgroundColor = [UIColor clearColor];
    Video *vi = [_DataArray objectAtIndex:indexPath.row];
    
    
    
    cell.video =vi;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10+(kSCREEN_WIDTH-20)/48 +(kSCREEN_WIDTH-60)/14 +20+((kSCREEN_WIDTH-60)*2/7+40+(kSCREEN_WIDTH-20)*2/3+10);

}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            cell.layer.transform =CATransform3DRotate(cell.layer.transform, M_PI, 0, 0, 1);
//        }];
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:0.5 animations:^{
//        cell.layer.transform =CATransform3DRotate(cell.layer.transform, M_PI, 0, 0, 1);
//            
//        }];
//   
//    }];
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
