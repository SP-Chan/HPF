//
//  ScrollViewController.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/13.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface ScrollViewController : UIViewController

@property(nonatomic,strong)UIScrollView *picScrollView;

@property(nonatomic,strong)NewsModel *news;




@end
