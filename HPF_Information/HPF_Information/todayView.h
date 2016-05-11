//
//  todayView.h
//  星座view
//
//  Created by lanou on 16/5/9.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface todayView : UIView
@property(nonatomic,strong)UIView *titleColumn;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UIView*rightView;
@property(nonatomic,strong)UIView *contentColumn;
@property(nonatomic,strong)NSDictionary *Datadic;
@property(nonatomic,strong)UILabel *date;
@property(nonatomic,strong)NSString *imageStr;
@property(nonatomic,strong)NSString *dateStr;

@end
