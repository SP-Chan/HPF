//
//  FlickAnimation.h
//  HPF_Information
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickAnimation : UIView
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableSet *buttonSet;
@property(nonatomic,strong)NSString *urlTime;
@property(nonatomic,strong)UILabel *lableDes;
@end
