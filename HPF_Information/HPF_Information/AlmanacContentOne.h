//
//  AlmanacContentOne.h
//  HPF_Information
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlmanacContentOne : UIView
@property(nonatomic,strong)UIView *LeftView;
@property(nonatomic,strong)UIView *RightView;
@property(nonatomic,strong)UIView *CentreView;
@property(nonatomic,strong)UIView *CentreLeft;
@property(nonatomic,strong)UIView *CentreRight;

@property(nonatomic,strong)UILabel *luckyTime;
@property(nonatomic,strong)UILabel *fierceTime;

@property(nonatomic,strong)UILabel *CentreLable;
@property(nonatomic,strong)UIView *CentreBelow;


@property(nonatomic,strong)UILabel *CentreLeftLabel;
@property(nonatomic,strong)UILabel *CentreRightLabel;
@end
