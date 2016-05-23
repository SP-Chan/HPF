//
//  QueryViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/9.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "QueryViewController.h"
#import "ResultViewController.h"
#import "DataBaseUtil.h"
@interface QueryViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HPFBaseButton *selectButton;
@property(nonatomic,strong)UIAlertController *alert;
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)HPFBaseLabel *historyLabel;
@property(nonatomic,strong)HPFBaseButton *historyButton;
@property(nonatomic,strong)HPFBaseImageView *iconImageView;
@property(nonatomic,strong)HPFBaseLabel *lineLabel;
@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DataBaseUtil shareDataBaseUtil]createTableWithTableName:@"Query"];
    [self createSelectView];
    
}
-(HPFBaseLabel *)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [[HPFBaseLabel alloc] initWithFrame:CGRectMake(5, 108, kSCREEN_WIDTH-10, 0.5)];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel;
}
-(HPFBaseLabel *)historyLabel
{
    if (!_historyLabel) {
        _historyLabel = [[HPFBaseLabel alloc] initWithFrame:CGRectMake(10, 110, kSCREEN_WIDTH/3, 30)];
        _historyLabel.text = @"历史记录";
//        _historyLabel.font = [UIFont systemFontOfSize:20];
        _historyLabel.font = [UIFont boldSystemFontOfSize:22];
//        _historyLabel.backgroundColor = [UIColor redColor];
    }
    return _historyLabel;
}
-(HPFBaseButton *)historyButton
{
    if (!_historyButton) {
        _historyButton = [HPFBaseButton buttonWithType:UIButtonTypeSystem];
        _historyButton.frame = CGRectMake(kSCREEN_WIDTH-kSCREEN_WIDTH/4-20, 110, kSCREEN_WIDTH/3, 30);
//        _historyButton.backgroundColor = [UIColor yellowColor];
//        _historyButton.layer.borderWidth = 1;
//        _historyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_historyButton setTitle:@"清空历史" forState:UIControlStateNormal];
        [_historyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"qingkong.png"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_historyButton setImage:image forState:UIControlStateNormal];
        [_historyButton addTarget:self action:@selector(delectHistory) forControlEvents:UIControlEventTouchDown];
    }
    return _historyButton;
}
-(void)delectHistory
{
    [[DataBaseUtil shareDataBaseUtil]deleteMessageWithTableName:@"Query"];
    [_tab reloadData];
}
-(UITableView *)tab
{
    if (!_tab) {
        _tab = [[UITableView alloc] initWithFrame:CGRectMake(5, 140, kSCREEN_WIDTH-10, kSCREEN_HEIGHT-140-49-64-64) style:UITableViewStylePlain];
        _tab.delegate = self;
        _tab.dataSource = self;
//        _tab.bounces = NO;
        _tab.showsVerticalScrollIndicator = NO;
        _tab.backgroundColor = [UIColor clearColor];
    }
    return _tab;
}
#pragma  mark- tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataBaseUtil shareDataBaseUtil] seleteBusesWithTableName:@"Query"].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSArray *array = [[DataBaseUtil shareDataBaseUtil] seleteBusesWithTableName:@"Query"];
    cell.textLabel.text = [array objectAtIndex:array.count-1 - indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultViewController *result = [[ResultViewController alloc] init];
    NSArray *array = [[DataBaseUtil shareDataBaseUtil] seleteBusesWithTableName:@"Query"];
    result.busNumber = [array objectAtIndex:array.count-1-indexPath.row];
    [self.navigationController pushViewController:result animated:YES];
}


#pragma mark- 创建界面
-(void)createSelectView
{
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.textFild];
    [self.view addSubview:self.selectButton];
    [self.view addSubview:self.tab];
    [self.view addSubview:self.historyLabel];
    [self.view addSubview:self.historyButton];
//    [self.view addSubview:self.lineLabel];
}
-(HPFBaseButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = [HPFBaseButton buttonWithType:UIButtonTypeSystem];
        [_selectButton setTitle:@"查询" forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _selectButton.frame = CGRectMake((kSCREEN_WIDTH-100)/2, 60, 100, 40);
        _selectButton.backgroundColor = [UIColor lightGrayColor];
        _selectButton.layer.cornerRadius = 5;
        _selectButton.layer.masksToBounds = YES;
        [_selectButton addTarget:self action:@selector(selectBuses:) forControlEvents:UIControlEventTouchDown];
//        self.layer.cornerRadius
//        self.layer.masksToBounds
    }
    return _selectButton;
}

-(HPFBaseImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[HPFBaseImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/7, 10, 35, 35)];
        _iconImageView.image = [UIImage imageNamed:@"icon_gongjiao"];
    }
    return _iconImageView;
}
-(UITextField *)textFild
{
    if (!_textFild) {
        _textFild = [[UITextField alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/6+40, 10, kSCREEN_WIDTH*2/3-kSCREEN_WIDTH/6, 35)];
        _textFild.layer.borderWidth = 1;
        _textFild.layer.borderColor = [UIColor grayColor].CGColor;
        _textFild.placeholder = @"  请输入线路名称:";
        _textFild.delegate = self;
    }
    return _textFild;
}

-(void)selectBuses:(HPFBaseButton *)btn
{
    if ([[[DataBaseUtil shareDataBaseUtil] seleteBusesWithTableName:@"Query"] containsObject:_textFild.text]) {
        
    }else
    {
        [[DataBaseUtil shareDataBaseUtil] addMessage:_textFild.text tableName:@"Query"];;
        [_tab reloadData];
    }
    if (_textFild.text.length > 0) {
        ResultViewController *result = [[ResultViewController alloc] init];
        result.busNumber = _textFild.text;
        [self.navigationController pushViewController:result animated:YES];
    }else{
        _alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请正确输入该车信息" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:_alert animated:YES completion:^{
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(reBack) userInfo:nil repeats:NO];
        }];
    }
}
-(void)reBack
{
    [_alert dismissViewControllerAnimated:YES completion:^{
    
    }];
}
#pragma mark- 回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textFild resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [_textFild resignFirstResponder];
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
