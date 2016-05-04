//
//  LocalViewController.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/3.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "LocalViewController.h"

@interface LocalViewController ()

@end

@implementation LocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
//    [self requestDatarequestWithType:GET UrlString:@"http://c.3g.163.com/nc/article/local/5bm%2F5bee/0-20.html" ParDic:nil Header:nil];
    
    
    [self createTableView];
    
    
    
    
    // Do any additional setup after loading the view.
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
