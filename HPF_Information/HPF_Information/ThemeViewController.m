//
//  ThemeViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/14.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "ThemeViewController.h"

@interface ThemeViewController ()
@property(nonatomic,strong)NSMutableArray *themeArray;
@property(nonatomic,strong)NSMutableArray *colorArray;
@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"切换风格";
    [self setData];
    [self createThemeButton];
}
-(void)setData
{
    [self.themeArray addObject:@"尼罗蓝"];
    [self.themeArray addObject:@"热带橙"];
    [self.themeArray addObject:@"深绯"];
    [self.themeArray addObject:@"月亮黄"];
    [self.themeArray addObject:@"草坪色"];
    
    [self.colorArray addObject:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:197/255.0 alpha:1]];//蓝
    [self.colorArray addObject:[UIColor colorWithRed:243/255.0 green:152/255.0 blue:57/255.0 alpha:1]];//橙
    [self.colorArray addObject:[UIColor colorWithRed:200/255.0 green:22/255.0 blue:29/255.0 alpha:1]];//红
    [self.colorArray addObject:[UIColor colorWithRed:255/255.0 green:237/255.0 blue:97/255.0 alpha:1]];//黄
    [self.colorArray addObject:[UIColor colorWithRed:189/255.0 green:203/255.0 blue:19/255.0 alpha:1]];//绿
}
-(NSMutableArray *)colorArray
{
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}
-(NSMutableArray *)themeArray
{
    if (!_themeArray) {
        _themeArray = [NSMutableArray array];
    }
    return _themeArray;
}
-(void)createThemeButton
{
    static int k = 0;
    //创建五个主题按钮
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            if (i == 1 && j == 2) {
                continue;
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:self.themeArray[k] forState:UIControlStateNormal];
            button.frame = CGRectMake(10+10*j+(kSCREEN_WIDTH-40)/3*j, 100+10*i+(kSCREEN_WIDTH-40)/3*1.5*i,(kSCREEN_WIDTH-40)/3, (kSCREEN_WIDTH-40)/3*1.5);
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            button.backgroundColor = self.colorArray[k];
            [button addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            k++;
        }
    }
    k=0;
}
-(void)dobutton:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeTheme object:nil];
    [[NSUserDefaults standardUserDefaults] setValue:button.titleLabel.text forKey:kChangeTheme];
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeTheme object:nil];
    [[NSUserDefaults standardUserDefaults] setValue:button.titleLabel.text forKey:kChangeTheme];
    NSLog(@"%@",button.titleLabel.text);
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
