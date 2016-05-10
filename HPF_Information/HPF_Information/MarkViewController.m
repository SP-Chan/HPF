//
//  MarkViewController.m
//  Uivew
//
//  Created by hui on 16/5/8.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import "MarkViewController.h"
#include "totalDataBaseUtil.h"
#import "Dream.h"
#import "DetailsDreamViewController.h"
@interface MarkViewController ()

@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setcontrols];
}
-(void)setcontrols
{
    self.tableView = [[UITableView alloc]init];
    _tableView.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
       _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil
                             ];
    _searchController.delegate=self;
    _searchController.searchResultsUpdater=self;
    _searchController.dimsBackgroundDuringPresentation=NO;
    _searchController.searchBar.placeholder=@"请输入你的梦境";
     [self.searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
//   _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    ;
     _searchController.dimsBackgroundDuringPresentation = NO;
     _searchController.hidesNavigationBarDuringPresentation = NO;
    [self.view addSubview:_searchController.searchBar];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *identifier =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    Dream *d = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text= d.title;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;


}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
 NSString *searchString = [self.searchController.searchBar text];


    
    if (searchString.length==0) {
        _dataArray = [[totalDataBaseUtil shareTotalDataBase]selectDreamWithParentld:self.identifier];
        [_tableView reloadData];
    }else{
        _dataArray = [[totalDataBaseUtil shareTotalDataBase]selectDreamWithTitle:searchString];
    
    [_tableView reloadData];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    DetailsDreamViewController *deta=[[DetailsDreamViewController alloc]init];
    
    deta.dream = [_dataArray objectAtIndex:indexPath.row];
    
    Dream *d = [_dataArray objectAtIndex:indexPath.row];
    NSLog(@"%@==%@",d.title,d.content);
    deta.modalTransitionStyle=UIModalPresentationCustom;
    if (_searchController.searchBar.text.length>0) {
        
         [_searchController presentViewController:deta animated:YES completion:nil];
        
        
       
    }else
    {
        [self presentViewController:deta animated:YES completion:nil];
    }
   
    
//    if (_searchController.searchBar.text.length>0) {
//        [self.searchController presentViewController:deta animated:YES completion:^{
//            
//        }];
//    }else
//    {
//    [self presentViewController:deta animated:YES completion:^{
//        
//    }];
//    
//    }
    
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    [self.navigationController popViewControllerAnimated:YES];
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
