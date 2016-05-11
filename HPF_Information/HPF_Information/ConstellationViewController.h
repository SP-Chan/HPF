//
//  ConstellationViewController.h
//  HPF_Information
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseViewController.h"
#import "todayView.h"
#import "NetworkRequestManager.h"
@interface ConstellationViewController : HPFBaseViewController
@property(nonatomic,strong)NSString *Constellation;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSDictionary *dataDic;
@end
