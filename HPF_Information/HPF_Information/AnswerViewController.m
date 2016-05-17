//
//  AnswerViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/14.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "AnswerViewController.h"
#import "VersionModel.h"
#import "AnswerTableViewCell.h"
@interface AnswerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *secitionArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *answerArray;
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"版本内容介绍";
    //    self.view.backgroundColor = [UIColor yellowColor];
    [self resetData];
    [self createNavgationLeftBarButton];
    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tab.dataSource = self;
    _tab.delegate = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tab];
}
-(void)resetData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"problem" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.dataArray = [dic objectForKey:@"key"];
    
    NSString *path_a = [[NSBundle mainBundle] pathForResource:@"answer" ofType:@"plist"];
    NSDictionary *dic_a = [[NSDictionary alloc] initWithContentsOfFile:path_a];
    self.answerArray = [dic_a objectForKey:@"key"];

    
    
    
}
-(NSMutableArray *)answerArray
{
    if (!_answerArray) {
        _answerArray = [NSMutableArray array];
    }
    return _answerArray;
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
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"新闻常见问题",@"天气常见问题",@"黄历常见问题",@"视频常见问题",@"出行常见问题", nil];
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
//    button.backgroundColor = [UIColor colorWithRed:172/255.0 green:218/255.0 blue:224/255.0 alpha:1];
//    button.layer.cornerRadius = 5;
//    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 0.4;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 50);
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
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerTableViewCell" owner:nil options:nil] lastObject];
    }
    NSMutableArray *array_a = [self.answerArray objectAtIndex:indexPath.section];
    cell.answerLabel.text = [array_a objectAtIndex:indexPath.row];
    NSMutableArray *array = [self.dataArray objectAtIndex:indexPath.section];
    cell.problemLabel.text = [array objectAtIndex:indexPath.row];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

#pragma mark- 创建左上的返回按钮
-(void)createNavgationLeftBarButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(reback)];
}
//返回方法
-(void)reback
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
