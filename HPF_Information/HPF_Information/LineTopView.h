//
//  LineTopView.h
//  HPF_Information
//
//  Created by XP on 16/5/10.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseView.h"

@interface LineTopView : HPFBaseView
@property(nonatomic,strong)HPFBaseLabel *startLabel;
@property(nonatomic,strong)HPFBaseLabel *finishLabel;
@property(nonatomic,strong)HPFBaseLabel *startTimeLabel;
@property(nonatomic,strong)HPFBaseLabel *finishTimeLabel;
@property(nonatomic,strong)HPFBaseLabel *picketPrice;
@property(nonatomic,strong)HPFBaseButton *changeButton;
@property(nonatomic,strong)HPFBaseLabel *lineLabel;
@end
