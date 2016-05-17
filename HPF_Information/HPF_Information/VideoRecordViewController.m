//
//  VideoRecordViewController.m
//  HPF_Information
//
//  Created by lanou on 16/5/14.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "VideoRecordViewController.h"
#import "RecordDataBase.h"
#import "UIImageView+WebCache.h"
#import "RecordDataBase.h"
#import "VideoPlayerViewController.h"
@interface VideoRecordViewController ()

@end

@implementation VideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setTableView];
    [self setdeletebutton];
    _DataArray = [NSMutableArray array];
    _DataArray = [[RecordDataBase shareRecordData]selectVideo];
}
-(void)setdeletebutton
{
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"shanchu.png"]forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem= rightItem;
    
    
    
    
}
-(void)delete
{
    
    [[RecordDataBase shareRecordData]deleteVideo];
    _DataArray = [[RecordDataBase shareRecordData]selectVideo];
    [self.tableView reloadData];
    
}
-(void)setTableView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    _tableView.delegate=self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Video *vi = [_DataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text =vi.title;
    cell.detailTextLabel.text =vi.post_time;
    
    
    NSURL *url = [NSURL URLWithString:vi.preview_img_url];
    [cell.imageView sd_setImageWithURL:url];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Video *vi = [_DataArray objectAtIndex:indexPath.row];
    
    VideoPlayerViewController *vid = [[VideoPlayerViewController alloc]init];
    
    vid.MP4Url = vi._id;
    vid.videoTitle = vi.title;
    
    
    
    [self presentViewController:vid animated:YES completion:^{
        
    }];
    
    
    
}
//允许编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}

//编辑模式(删除)
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//控制编辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Video *vi = [_DataArray objectAtIndex:indexPath.row];
    
    [[RecordDataBase shareRecordData]deleteVideoWithTitle:vi.title];
    [_DataArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationRight];
    
    
}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    
    return @"删除";
    
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
