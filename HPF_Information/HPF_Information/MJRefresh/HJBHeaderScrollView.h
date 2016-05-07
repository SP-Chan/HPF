//
//  HJBHeaderScrollView.h
//  05-图片轮播器
//
//  Created by 小明 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJBHeaderScrollView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)array;

- (void)addTimer;
- (void)removeTimer;
@end
