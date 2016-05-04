//
//  TimeSelector.h
//  HPF_Information
//
//  Created by hui on 16/5/2.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlmanacViewController.h"

@interface TimeSelector : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView *pickerV;


@end
