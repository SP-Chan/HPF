//
//  General.h
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#ifndef General_h
#define General_h

/**
 * 屏幕的宽度
 */
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**
 * 屏幕高度
 */
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 * 切换主题发送的Notification
 */
#define kChangeTheme @"kChangeTheme"
/**
 * 百度APIKey
 **/
#define kBaiDuAPIKey @"5a459f84da963ce86b81254b69783481"
/**
 * 聚合APIKey
 **/
#define kJuHeAPIKey @"f42334b47586bfd62de709c03db94cec"
/**
 * 切换公交城市
 **/
#define kBusCity @"kBusCity"

/**
 * 定位城市
 **/
#define kLocationCity @"lLocationCity"
/**
 * 当前温度
 **/
#define kCurrentWeather @"kCurrentWeather"
/**
 * 更改 r g b a设置RGB颜色
 **/
#define KColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]
#endif /* General_h */
