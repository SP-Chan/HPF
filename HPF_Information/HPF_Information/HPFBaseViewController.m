//
//  HPFBaseViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseViewController.h"

@interface HPFBaseViewController ()

@end

@implementation HPFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设定默认模式背景色
    [self setBackgroundViewColor];
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNightTheme:) name:kChangeTheme object:nil];
}

#pragma mark- 夜间模式设置
//从 LeftViewController 接收通知
-(void)changeNightTheme:(NSNotification *)notification
{
    //更新背景色
    [self setBackgroundViewColor];
}

//设定背景色
-(void)setBackgroundViewColor
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kChangeTheme];
    if ([string isEqualToString:@"night"]) {
        self.view.backgroundColor = [UIColor colorWithRed:66/255.0 green:79/255.0 blue:105/255.0 alpha:1];
    }else if ([string isEqualToString:@"深绯"]){
        self.view.backgroundColor = [UIColor colorWithRed:209/255.0 green:135/255.0 blue:131/255.0 alpha:1];
    }else if ([string isEqualToString:@"尼罗蓝"]){
        self.view.backgroundColor = [UIColor colorWithRed:202/255.0 green:224/255.0 blue:169/255.0 alpha:1];
    }else if ([string isEqualToString:@"热带橙"]){
        self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:226/255.0 blue:180/255.0 alpha:1];
    }else if ([string isEqualToString:@"月亮黄"]){
        self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:172/255.0 blue:87/255.0 alpha:1];
    }else if ([string isEqualToString:@"草坪色"]){
        self.view.backgroundColor = [UIColor colorWithRed:91/255.0 green:194/255.0 blue:217/255.0 alpha:1];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark 创建新闻类tableview
//-(void)requestDatarequestWithType:(RequestType)type UrlString:(NSString *)urlString ParDic:(NSDictionary *)parDic Header:(NSString *)header
//{
//    [NetworkRequestManager requestWithType:type urlString:urlString ParDic:parDic Header:header finish:^(NSData *data) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self createNewsTabelView];
//        });
//
//    } err:^(NSError *error) {
//
//    }];
//}
//
//-(void)createNewsTabelView
//{
//
//    _tabV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-35-110) style:UITableViewStylePlain];
//    [self.view addSubview:_tabV];
//    _tabV.delegate = self;
//    _tabV.dataSource = self;
//
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 5;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *identifier = @"cell";
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//    }
//    return cell;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 150;
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
