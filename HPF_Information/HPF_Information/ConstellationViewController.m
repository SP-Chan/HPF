//
//  ConstellationViewController.m
//  HPF_Information
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "ConstellationViewController.h"
#import "activityView.h"
#import "Constellation.h"
@interface ConstellationViewController ()
@property(nonatomic,strong)UIActivityIndicatorView *activity;
@end

@implementation ConstellationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
 
    
 
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(Back)];
    
[self DataRequest];

    
}
-(void)Back
{

    [self.navigationController popViewControllerAnimated:YES];

}
-(void)DataRequest
{
    
    for (UIView *view in self.view.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    
    activityView *act = [[activityView alloc]init];
    [self.view addSubview:act];
    [act setActivityColor:[UIColor blackColor]];
    
    NSString *url = [NSString stringWithFormat:@"http://web.juhe.cn:8080/constellation/getAll?consName=%@&type=today&key=84e66b5d485806c4a747d360f5ab8b58",_Constellation];
    
    [NetworkRequestManager requestWithType:GET urlString:url ParDic:nil Header:nil finish:^(NSData *data) {
        
        
        _dataDic = [NSDictionary dictionary];
        NSError *error = nil;
       _dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        
        Constellation *con =[[Constellation alloc]init];
        [con setValuesForKeysWithDictionary:_dataDic];
//        NSLog(@"key=%@,values=%@",[_dataDic allKeys],[_dataDic allValues]);
        
        if (_dataDic.count>4) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addtodayView];
                [act removeFromSuperview];
                
            });
        
            
        }else
        {
        
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络出现一点小问题" message:@"返回界面重试" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ale  =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            [alert addAction:ale];
            
            
         

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self presentViewController:alert animated:YES completion:^{
                        
                    }];
                });
          
            
            
           
            
            
        }
       
        
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
