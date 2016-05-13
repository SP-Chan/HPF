//
//  TripViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "TripViewController.h"
#import "NetworkRequestManager.h"
#import "QueryViewController.h"
#import "LineViewController.h"
#import "StationViewController.h"
#import "ChangeCityViewController.h"
@interface TripViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *transportScrollView;
@property(nonatomic,strong)NSMutableArray *buttonArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)HPFBaseView *topBackgroundView;
//@property(nonatomic,strong)QueryViewController *query;
@property(nonatomic,strong)HPFBaseButton *rightButton;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)NSMutableArray *blackImageArray;
@end

@implementation TripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"实时公交";
    
    [self createUI];
    self.tabBarController.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCity:) name:@"changeCity" object:nil];
}
-(void)changeCity:(NSNotification *)notification
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kBusCity];
    [_rightButton setTitle:[NSString stringWithFormat:@"[%@]",string] forState:UIControlStateNormal];
}
-(void)createUI
{
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"[广州]" style:UIBarButtonItemStyleDone target:self action:@selector(changeCity)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.view addSubview:self.topBackgroundView];
    [self.view addSubview:self.transportScrollView];
    
}
#pragma mark- 右上角button
-(HPFBaseButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [HPFBaseButton buttonWithType:UIButtonTypeSystem];
        _rightButton.frame = CGRectMake(0, 0, 60, 44);
        NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kBusCity];
        [_rightButton setTitle:[NSString stringWithFormat:@"[%@]",string] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(changeCity) forControlEvents:UIControlEventTouchDown];
    }
    return _rightButton;
}
-(void)changeCity
{
    ChangeCityViewController *change = [[ChangeCityViewController alloc] init];
    [self.navigationController pushViewController:change animated:YES];
}
#pragma mark- 主体的scrollView
-(UIScrollView *)transportScrollView
{
    if (!_transportScrollView) {
        _transportScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, kSCREEN_WIDTH, kSCREEN_HEIGHT-50)];
        
        QueryViewController *query = [[QueryViewController alloc] init];
        
        LineViewController *line = [[LineViewController alloc] init];
        StationViewController *station = [[StationViewController alloc] init];
        [self addChildViewController:query];
        [self addChildViewController:line];
        [self addChildViewController:station];
        
        for (int i = 0; i < self.childViewControllers.count; i++) {
            HPFBaseViewController *viewControll = self.childViewControllers[i];
            viewControll.view.frame = CGRectMake(self.transportScrollView.frame.size.width*i, 0, self.transportScrollView.frame.size.width, self.transportScrollView.frame.size.height-50);
            [_transportScrollView addSubview:viewControll.view];

        }
        _transportScrollView.contentSize = CGSizeMake(self.transportScrollView.frame.size.width*3, self.transportScrollView.frame.size.height-50);
        _transportScrollView.pagingEnabled = YES;
        _transportScrollView.bounces = NO;
        _transportScrollView.delegate = self;
        
    }
    return _transportScrollView;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger number = scrollView.contentOffset.x/_transportScrollView.frame.size.width;
    NSLog(@"%ld",(long)(long)number);
    for (int i = 0; i<3; i++) {
        if (number == i) {
            HPFBaseButton *button = (HPFBaseButton *)[_topBackgroundView viewWithTag:number+1];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17];
            [button setImage:[UIImage imageNamed:self.blackImageArray[i]] forState:UIControlStateNormal];
            self.navigationItem.title = button.titleLabel.text;
            
        }else
        {
            HPFBaseButton *button = (HPFBaseButton *)[_topBackgroundView viewWithTag:i+1];
            //还原被点击的字体颜色
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        }
    }

}

-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"实时公交",@"公交线路",@"公交站查询", nil];
    }
    return _titleArray;
}
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:@"gongjiao.png",@"luxian.png",@"zhandian.png", nil];
    }
    return _imageArray;
}
-(NSMutableArray *)blackImageArray
{
    if (!_blackImageArray) {
        _blackImageArray = [NSMutableArray arrayWithObjects:@"gongjiao_black.png",@"luxian_black.png",@"zhandian_black.png", nil];
    }
    return _blackImageArray;
}
-(NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
#pragma mark 三个Button
-(HPFBaseView *)topBackgroundView
{
    if (!_topBackgroundView) {
        _topBackgroundView = [[HPFBaseView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
//        _topBackgroundView.backgroundColor = [UIColor redColor];
        _topBackgroundView.layer.cornerRadius = 5;
        _topBackgroundView.layer.masksToBounds = YES;
        for(int i = 0; i<3; i++) {
            //button 大小
            HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((i+1)*5+(kSCREEN_WIDTH-20)/3*i, 5, (kSCREEN_WIDTH-20)/3, 40);
            
            button.tag = i+1;
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.layer.borderWidth = 0.6;
            [_topBackgroundView addSubview:button];
            [button addTarget:self action:@selector(changeController:) forControlEvents:UIControlEventTouchUpInside];
            //button 图片
            if (i == 0) {
                [button setImage:[UIImage imageNamed:self.blackImageArray[i]] forState:UIControlStateNormal];
            }else{
                [button setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];

            }
            //button 字体
            [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
            
            if (i == 0) {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:17];
                
            }else
            {
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            [self.buttonArray addObject:button];
        }

    }
    return _topBackgroundView;
}


-(void)changeController:(HPFBaseButton *)btn
{
    for (int i = 0; i<3; i++) {
        if (btn.tag == i+1) {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
            self.navigationItem.title = btn.titleLabel.text;
            [btn setImage:[UIImage imageNamed:self.blackImageArray[i]] forState:UIControlStateNormal];
        }else
        {
            //还原被点击的字体颜色
            UIButton *button = [self.buttonArray objectAtIndex:i];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
          
        }
        
    }
   self.transportScrollView.contentOffset = CGPointMake(kSCREEN_WIDTH*(btn.tag-1), 0);
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
