//
//  WebViewController2.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/6.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "WebViewController.h"
//#import "SXDetailModel.h"
//#import "SXDetailImgModel.h"


@interface WebViewController ()

//@property (nonatomic, strong)SXDetailModel *detailModel;
@property(nonatomic,strong)UIActivityIndicatorView *ActivityIndicator;
@property(nonatomic,strong)UIView *actiView;
@property(nonatomic,strong)UILabel *label;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.navigationController.navigationBar.hidden = YES;
    
    _webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [self.view addSubview:_webV];
    NSURL *url = [NSURL URLWithString:self.news.url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webV loadRequest:request];
    
    _webV.delegate = self;
    
    _webV.scrollView.bounces = NO;
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT/13.6)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.webV addSubview:view];
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT/13.7)];
    headLabel.backgroundColor = [UIColor colorWithRed:8.6 green:10.1 blue:9.5 alpha:1];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.text = @"内容来源自网易";
    [self.webV addSubview:headLabel];
    
    // Do any additional setup after loading the view.
}







- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    
    
    if (!_actiView) {
        _actiView = [[UIView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2.85, kSCREEN_HEIGHT/4, kSCREEN_WIDTH/3.3, kSCREEN_HEIGHT/6)];
        _actiView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        _actiView.layer.cornerRadius = 10;
        _actiView.layer.masksToBounds = YES;
        [_webV addSubview:_actiView];
        
        if (_ActivityIndicator == nil) {
            //菊花;
            _ActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            //        _ActivityIndicator.center = CGPointMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/4);
            _ActivityIndicator.center = _actiView.center;
            
            [self.view addSubview:_ActivityIndicator];
            
            [_ActivityIndicator startAnimating]; 
        }
        
        if (!_label) {
            _label = [[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2.25, kSCREEN_HEIGHT/3.3, kSCREEN_WIDTH/3.3, kSCREEN_HEIGHT/6)];
            _label.text = @"加载中";
            _label.backgroundColor = [UIColor clearColor];
            [self.view addSubview:_label];
        }
        
    }
    
    
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopActivityIndicator) userInfo:self repeats:YES];
    
    
}

-(void)stopActivityIndicator
{
    [_ActivityIndicator stopAnimating]; // 结束旋转
    [_ActivityIndicator setHidesWhenStopped:YES];
    [self.actiView removeFromSuperview];
    [self.label removeFromSuperview];
}




-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
//     [_webV stringByEvaluatingJavaScriptFromString:@"document.body.style.background='red'"];
    
    
    //webView日间与夜间模式下背景颜色的切换
//    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kChangeTheme];
//    if ([string isEqualToString:@"night"]) {
//        
//        [_webV stringByEvaluatingJavaScriptFromString:@"document.body.style.background='red'"];
//    }else{
//         [_webV stringByEvaluatingJavaScriptFromString:@"document.body.style.background='white'"];
//    }
    
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
