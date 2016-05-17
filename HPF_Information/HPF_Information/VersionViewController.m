//
//  VersionViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/14.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "VersionViewController.h"
#import "VersionModel.h"
@interface VersionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *secitionArray;
@property(nonatomic,strong)NSMutableArray *leftViewArray;
@property(nonatomic,strong)NSMutableArray *newsArray;
@property(nonatomic,strong)NSMutableArray *almanaArray;
@property(nonatomic,strong)NSMutableArray *videoArray;
@property(nonatomic,strong)NSMutableArray *busArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation VersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"版本内容介绍";
//    self.view.backgroundColor = [UIColor yellowColor];
    [self resetData];
    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tab.dataSource = self;
    _tab.delegate = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tab];
}
-(void)resetData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Version" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *array = [dic objectForKey:@"key"];
    self.busArray = [array objectAtIndex:0];
    self.newsArray = [array objectAtIndex:3];
    self.videoArray = [array objectAtIndex:1];
    self.leftViewArray = [array objectAtIndex:4];
    self.almanaArray = [array objectAtIndex:2];
    
    [self.dataArray addObject:self.leftViewArray];
    [self.dataArray addObject:self.newsArray];
    [self.dataArray addObject:self.almanaArray];
    [self.dataArray addObject:self.videoArray];
    [self.dataArray addObject:self.busArray];
    
    
   
    
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)secitionArray
{
    if (!_secitionArray) {
         _secitionArray = [NSMutableArray array];
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"左视图",@"新闻",@"黄历",@"视频",@"出行", nil];
        for (int i = 0; i < 5; i++) {
            VersionModel *model = [[VersionModel alloc] init];
            model.title = [array objectAtIndex:i];
            model.isOpen = NO;
            [_secitionArray addObject:model];
        }
    }
    return _secitionArray;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:172/255.0 green:218/255.0 blue:224/255.0 alpha:1];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 10, kSCREEN_WIDTH-20, 30);
    button.tag = section;
    VersionModel *model = [self.secitionArray objectAtIndex:section];
    [button setTitle:model.title forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(touchMe:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.secitionArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSMutableArray *array = [self.dataArray objectAtIndex:section];
    VersionModel *model = [_secitionArray objectAtIndex:section];
    if (model.isOpen) {
        return array.count;
    }else{
       return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSMutableArray *array = [self.dataArray objectAtIndex:indexPath.section];
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
}
-(void)touchMe:(UIButton *)btn
{
    VersionModel *mo = [self.secitionArray objectAtIndex:btn.tag];
    if (mo.isOpen) {
        mo.isOpen = NO;
    }
    else
    {
        mo.isOpen = YES;
    }
    [_tab reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationMiddle];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(NSMutableArray *)leftViewArray
{
    if (!_leftViewArray) {
        _leftViewArray = [NSMutableArray array];
    }
    return _leftViewArray;
}
-(NSMutableArray *)newsArray
{
    if (!_newsArray) {
        _newsArray = [NSMutableArray array];
    }
    return _newsArray;
}
-(NSMutableArray *)almanaArray
{
    if (!_almanaArray) {
        _almanaArray = [NSMutableArray array];
    }
    return _almanaArray;
}
-(NSMutableArray *)busArray
{
    if (!_busArray) {
        _busArray = [NSMutableArray array];
    }
    return _busArray;
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
