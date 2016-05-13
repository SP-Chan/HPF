//
//  WebViewController2.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/6.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseViewController.h"
#import "NewsModel.h"
#import <WebKit/WebKit.h>



@interface WebViewController : HPFBaseViewController

@property(nonatomic,strong)NewsModel *news;

@property (nonatomic,strong)WKWebView *webView;





@end
