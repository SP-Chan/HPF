//
//  ScrollViewController.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/13.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "ScrollViewController.h"
#import "UIImageView+WebCache.h"

@interface ScrollViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIImageView *imageV;

@end

@implementation ScrollViewController

-(UIScrollView *)picScrollView
{
    if (!_picScrollView) {
        self.picScrollView = [[UIScrollView alloc]init];
    }
    
    return _picScrollView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    [self loadPicScrollView];
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)loadPicScrollView
{
    self.picScrollView.frame = CGRectMake(0, kSCREEN_HEIGHT/6, kSCREEN_WIDTH, kSCREEN_HEIGHT/2.5);
    _picScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH*3, 0);
    [self.view addSubview:_picScrollView];
    _picScrollView.backgroundColor = [UIColor grayColor];
    _picScrollView.pagingEnabled = YES;
    _picScrollView.showsHorizontalScrollIndicator = NO;
    
    
    for (int i = 0; i < 3; i++) {
        
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT/2.5)];
        UIScrollView *sm = [[UIScrollView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH*i, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT/2.5)];
        
        if (i == 0) {
           [self.imageV sd_setImageWithURL:[NSURL URLWithString:_news.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        else if (i == 1)
        {
            [self.imageV sd_setImageWithURL:[NSURL URLWithString:[_news.imgextra[0]objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        else
        {
           [self.imageV sd_setImageWithURL:[NSURL URLWithString:[_news.imgextra[1]objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        
        
        [sm addSubview:_imageV];
        [_picScrollView addSubview:sm];
    }
    
    
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
