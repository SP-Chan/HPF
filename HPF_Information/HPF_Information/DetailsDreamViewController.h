//
//  DetailsDreamViewController.h
//  Uivew
//
//  Created by hui on 16/5/8.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dream.h"
@interface DetailsDreamViewController : UIViewController
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *details;
@property(nonatomic,strong)Dream *dream;
@property(nonatomic,strong)UIImageView *imageV;
@end
