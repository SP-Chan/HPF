//
//  DetailsDreamViewController.m
//  Uivew
//
//  Created by hui on 16/5/8.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import "DetailsDreamViewController.h"
#import "MarkViewController.h"
@interface DetailsDreamViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)MarkViewController *mark;
@end

@implementation DetailsDreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addcontrols];
     
}
-(void)addcontrols
{
    self.imageV = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.imageV.image= [UIImage imageNamed:@"9252150_140911456000_2.jpg"];
    [self.view addSubview:self.imageV];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(20, 20, kSCREEN_WIDTH-40, kSCREEN_HEIGHT-74)];
    
    self.webView.backgroundColor= [UIColor clearColor];
    [(UIScrollView *)[[self.webView subviews] objectAtIndex:0] setBounces:NO];
   
    
    for (UIScrollView * subview in self.webView.subviews)
    {
        subview.showsVerticalScrollIndicator=NO;
        
        subview.layer.cornerRadius=20;
        subview.layer.masksToBounds=YES;
        subview.backgroundColor = [UIColor grayColor];
        
        
        
    }
    
    self.webView.delegate=self;
    
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:_dream.content baseURL:nil];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, kSCREEN_HEIGHT-52, kSCREEN_WIDTH-40,42);
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds=YES;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [button addTarget:self action:@selector(onPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)onPage
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
   

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='gray'"];

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
