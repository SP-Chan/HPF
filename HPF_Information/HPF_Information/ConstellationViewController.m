//
//  ConstellationViewController.m
//  HPF_Information
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "ConstellationViewController.h"

@interface ConstellationViewController ()
@property(nonatomic,strong)UIActivityIndicatorView *activity;
@end

@implementation ConstellationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _dataDic = [NSDictionary dictionary];
    
    
    
    for (UIView *view in self.view.subviews) {
        
        [view removeFromSuperview];
    }
    
    
    [self DataRequest];
    
}
-(void)DataRequest
{
    
    _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _activity.layer.position=CGPointMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2-64);
    [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_activity setColor:[UIColor blackColor]];
    [self.view addSubview:_activity];
    [_activity startAnimating];
    
    NSString *url = [NSString stringWithFormat:@"http://web.juhe.cn:8080/constellation/getAll?consName=%@&type=today&key=84e66b5d485806c4a747d360f5ab8b58",_Constellation];
    
    [NetworkRequestManager requestWithType:GET urlString:url ParDic:nil Header:nil finish:^(NSData *data) {
        
        
        
        NSError *error = nil;
       _dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addtodayView];
            [_activity stopAnimating];
            
        });
        
    } err:^(NSError *error) {
        
    }];
    
    
    
}


-(void)addtodayView
{
    todayView *today = [[todayView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:today];
    
    
    today.name.text=self.Constellation;

    today.imageStr=self.image;
    today.dateStr=self.date;
    today.date.text = [_dataDic objectForKey:@"datetime"];
   
    today.Datadic=_dataDic;
    
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
