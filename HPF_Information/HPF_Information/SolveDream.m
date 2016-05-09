//
//  SolveDream.m
//  icon
//
//  Created by lanou on 16/5/6.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import "SolveDream.h"
#import "totalDataBaseUtil.h"
#import "Dream.h"

@implementation SolveDream

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT, self.bounds.size.width, self.bounds.size.height)];
        
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        
     _dataArray = [NSMutableArray array];
        _FindArray = [NSMutableArray array];
        _contentArray  =[NSMutableArray array];
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.delegate=self;
        _searchController.searchResultsUpdater=self;
        _searchController.dimsBackgroundDuringPresentation=NO;
        
        _searchController.searchBar.placeholder=@"请输入你的梦境";
           _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
        
        [self addSubview:self.searchController.searchBar];
        [UIView animateWithDuration:0.5 animations:^{
            
            self.tableView.frame=CGRectMake(0, 20, self.bounds.size.width, self.bounds.size.height);
        }];
        
        
    }
    return self;

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return  _FindArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    cell.textLabel.text=[ _FindArray objectAtIndex:indexPath.row];
    
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    
    NSString *searchString = [self.searchController.searchBar text];
    

    if (searchString.length>0) {
    _dataArray = [[totalDataBaseUtil shareTotalDataBase]selectDreamWithTitle:searchString];
    }
    
    
    for (Dream *dre in _dataArray) {
        [_FindArray addObject:dre.title];
       
        [_contentArray addObject:dre.content];
    }
    if (_FindArray.count>0) {
        self.tableView.tableHeaderView=_searchController.searchBar;
        [self addSubview:_tableView];
     [_tableView reloadData];
   }
}
//测试UISearchController的执行过程
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%@",[_FindArray objectAtIndex:indexPath.row]);
    NSLog(@"%@",[_contentArray objectAtIndex:indexPath.row]);
    
   
}
//- (void)willPresentSearchController:(UISearchController *)searchController
//{
//    NSLog(@"将要开始点击触发");
//    [_tableView reloadData];
//    
//    if ([_dataArray count]>0) {
//         self.tableView.tableHeaderView=_searchController.searchBar;
//    [self addSubview:_tableView];
//    }
//   
//}
//
//- (void)didPresentSearchController:(UISearchController *)searchController
//{
//    NSLog(@"当前搜索器");
//}
//
- (void)willDismissSearchController:(UISearchController *)searchController
{
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame= CGRectMake(0, kSCREEN_HEIGHT, self.bounds.size.width, self.bounds.size.height);
    }];
    
    [self removeFromSuperview];
}

//- (void)didDismissSearchController:(UISearchController *)searchController
//{
//    NSLog(@"didDismissSearchController");
//}
//
//- (void)presentSearchController:(UISearchController *)searchController
//{
//    NSLog(@"presentSearchController");
//}



@end
