//
//  LocalViewController.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/3.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseViewController.h"


@interface LocalViewController : HPFBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArary;
@property(nonatomic,strong)UITableView *tabView;




@end
