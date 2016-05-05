//
//  MinWeather.h
//  HPF_Information
//
//  Created by XP on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseView.h"

@interface MinWeather : HPFBaseView
@property (weak, nonatomic) IBOutlet UIImageView *minWeatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *minWeather;
@property (weak, nonatomic) IBOutlet UILabel *minDate;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDegreeLabel;

@end
