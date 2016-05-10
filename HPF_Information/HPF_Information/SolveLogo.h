//
//  SolveLogo.h
//  Uivew
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBSphereView.h"
@interface SolveLogo : UIView
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)NSMutableArray *buttonArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,strong)UIButton *titleButton;
@property(nonatomic,strong)DBSphereView *dbSphere;
@end
