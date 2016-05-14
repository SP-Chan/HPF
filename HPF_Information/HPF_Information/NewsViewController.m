//
//  NewsViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "NewsViewController.h"
#import "HPFBaseButton.h"

#import "LocalViewController.h"     //本地
#import "AmusementViewController.h" //娱乐
#import "SportsViewController.h"   //体育
#import "ScienceViewController.h"  //科技
#import "CarViewController.h"      //汽车
#import "VogueViewController.h"    //时尚
#import "HouseViewController.h"    //房产
#import "MilitaryViewController.h" //军事
#import "HistoryViewController.h"  //历史
#import "PhoneViewController.h"    //手机
#import "EmotionViewController.h"  //情感
#import "EducationViewController.h"//教育
#import "LocationViewController.h"
#import "HPFBaseNavigationController.h"
@interface NewsViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)HPFBaseButton *leftButton;//左上角抽屉按钮
@property(nonatomic,strong)HPFBaseButton *rightButton;//右上角定位按钮
@property(nonatomic,assign)BOOL isShowLeftView;
@property(nonatomic,strong)UIScrollView *titleSc;
@property(nonatomic,strong)UIScrollView *newsSc;
@property(nonatomic,strong)NSMutableArray *btnArray;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    [self createLefBarButton];
    [self createRightButton];
    [self createTitleScrollView];
    [self creareNewsScrollview];
    
      
    
}
#pragma mark  主页的scrollview
-(void)creareNewsScrollview
{
    
    LocalViewController *local = [[LocalViewController alloc]init];
    AmusementViewController *amusement = [[AmusementViewController alloc]init];
    SportsViewController *sports = [[SportsViewController alloc]init];
    ScienceViewController *science = [[ScienceViewController alloc ]init];
    CarViewController *car = [[CarViewController alloc]init];
    VogueViewController *vogue = [[VogueViewController alloc]init];
    HouseViewController *house = [[HouseViewController alloc]init];
    MilitaryViewController *military = [[MilitaryViewController alloc]init];
    HistoryViewController *history = [[HistoryViewController alloc]init];
    PhoneViewController *phone = [[PhoneViewController alloc]init];
    EmotionViewController *emotion = [[EmotionViewController alloc]init];
    EducationViewController *education = [[EducationViewController alloc]init];
    
    [self addChildViewController:local];
    [self addChildViewController:amusement];
    [self addChildViewController:sports];
    [self addChildViewController:science];
    [self addChildViewController:car];
    [self addChildViewController:vogue];
    [self addChildViewController:house];
    [self addChildViewController:military];
    [self addChildViewController:history];
    [self addChildViewController:phone];
    [self addChildViewController:emotion];
    [self addChildViewController:education];
    
    _newsSc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 35, kSCREEN_WIDTH, kSCREEN_HEIGHT-35-110)];
    [self.view addSubview:_newsSc];
    _newsSc.contentSize = CGSizeMake(kSCREEN_WIDTH*12, 0);
    
    _newsSc.pagingEnabled = YES;
    _newsSc.delegate = self;
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *viewController = self.childViewControllers[i];
        viewController.view.frame = CGRectMake(_newsSc.frame.size.width*i, 0, _newsSc.frame.size.width, _newsSc.frame.size.height);
        viewController.view.tag = i;
        [_newsSc addSubview:viewController.view];
    }
    
}


//栏目标题的scrollview
-(void)createTitleScrollView
{
    
    _titleSc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 35)];
    [self.view addSubview:_titleSc];
    _titleSc.contentSize = CGSizeMake(kSCREEN_WIDTH/6*12, 0);
    _titleSc.showsHorizontalScrollIndicator = NO;
    
    NSArray *array = [NSArray arrayWithObjects:@"本地",@"娱乐",@"体育",@"经济",@"汽车",@"时尚",@"房产",@"军事",@"历史",@"手机",@"情感",@"教育", nil];
    _btnArray = [NSMutableArray array];
    
    for (int i = 0; i < 12; i++) {
        HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kSCREEN_WIDTH/6*i, 0, kSCREEN_WIDTH/6, 35);
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
        button.tag = i;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        if (button.tag == 0) {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        }
        
        [_btnArray addObject:button];
        [_titleSc addSubview:button];
        
        [button addTarget:self action:@selector(touchTitleButton:) forControlEvents:UIControlEventTouchDown];
        
    }
    
}

#pragma mark 左右滑动主页面
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger number = _newsSc.contentOffset.x/kSCREEN_WIDTH;
    
    if ((number > 5)) {
        [UIView animateWithDuration:0.5 animations:^{
            _titleSc.contentOffset = CGPointMake(kSCREEN_WIDTH, 0);
        }];
    }
    if (number < 6) {
        [UIView animateWithDuration:0.5 animations:^{
            _titleSc.contentOffset = CGPointMake(0, 0);
        }];
    }
    
    for (int i = 0; i < _btnArray.count; i++) {
        if (number == i) {
            UIButton *button = [_btnArray objectAtIndex:number];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        }
        else
        {
            UIButton *button = [_btnArray objectAtIndex:i];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
        }
    }
}

#pragma mark 点击标题栏切换页面
-(void)touchTitleButton:(HPFBaseButton *)button
{
    for (int i = 0 ; i < _btnArray.count; i++) {
        if (button.tag == i) {
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            
        }
        else
        {
            UIButton *button = [_btnArray objectAtIndex:i];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];

        }
         _newsSc.contentOffset = CGPointMake(button.tag*kSCREEN_WIDTH, 0);
    }
}
#pragma mark- 右上方的定位键
-(void)createRightButton
{
    if (_rightButton == nil)
    {
        _rightButton = [HPFBaseButton buttonWithType:UIButtonTypeSystem];
        _rightButton.frame = CGRectMake(kSCREEN_WIDTH - 37, kSCREEN_HEIGHT * 0.1 - 35, 30, 30);
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
//        [_imageView addSubview:_searchButton];
        [_rightButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//点击搜索 弹出搜索视图控制器
-(void)searchButtonAction:(UIButton *)button
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kLocationCity];
    LocationViewController *locationVC = [[LocationViewController alloc]init];
    HPFBaseNavigationController *navLocation = [[HPFBaseNavigationController alloc] initWithRootViewController:locationVC];
    if (string.length>0) {
        locationVC.city = string;
    }else{
        locationVC.city = @"广州";
    }
//    locationVC.city = self.titleArr[1];
    [self presentViewController:navLocation animated:YES completion:NULL];
}
#pragma mark- 左上方的侧栏键
-(void)createLefBarButton
{
    self.leftButton = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(0, 0, 40, 40);
    [self.leftButton setImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(showLeftView:) forControlEvents:UIControlEventTouchUpInside];
    _isShowLeftView = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeIsShowLeftView:) name:@"changeIsShowLeftView" object:nil];
    
}
//点击事件
-(void)showLeftView:(HPFBaseButton *)button
{
    //发送通知到 ViewController
    if (_isShowLeftView == NO) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"showLeftView" object:nil];
        _isShowLeftView = YES;
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenLeftView" object:nil];
        _isShowLeftView = NO;
    }
   
}
-(void)changeIsShowLeftView:(NSNotification *)notification
{
    _isShowLeftView = NO;
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
