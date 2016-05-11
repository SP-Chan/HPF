//
//  AlmanacContentTwo.h
//  HPF_Information
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface AlmanacContentTwo : UIView<CLLocationManagerDelegate>
@property(nonatomic,strong)UIView *LeftOneView;
@property(nonatomic,strong)UIView *RightOneView;

@property(nonatomic,strong)UIView *CentreView;
@property(nonatomic,strong)UILabel *LeftLable;
@property(nonatomic,strong)UILabel *RightLable;
@property(nonatomic,strong)UIButton *CentreButton;


@property(nonatomic,strong)CLLocationManager *LocManager;

@end
