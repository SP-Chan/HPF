//
//  HPFBaseViewController.h
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPFBaseViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tabV;



//-(void)requestDatarequestWithType:(RequestType)type UrlString:(NSString *)urlString ParDic:(NSDictionary *)parDic Header:(NSString *)header;

@end
