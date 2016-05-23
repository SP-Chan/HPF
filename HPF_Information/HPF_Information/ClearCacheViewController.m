//
//  ClearCacheViewController.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/14.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "ClearCacheViewController.h"

@interface ClearCacheViewController ()

@property(nonatomic,strong)UIImageView *imageV;




@end

@implementation ClearCacheViewController

-(UIImageView *)imageV
{
    if (!_imageV) {
        self.imageV = [[UIImageView alloc]init];
    }
    return _imageV;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageV.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    _imageV.image = [UIImage imageNamed:@"CacheImage"];
    [self.view addSubview:_imageV];
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
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
