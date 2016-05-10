//
//  Annotation.h
//  MapView
//
//  Created by XP on 16/5/9.
//  Copyright © 2016年 P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//自定义标注视图,一定要遵守MKAnnotation这个协议
@interface Annotation : NSObject<MKAnnotation>

//下面三个属是MKAnnotation协议里面的三个属性,其中coordinate是必须实现的属性,而且属性名不能写错,因为写错了,就是其他属性了.这样必须实现的属性相当于没有实现
@property(nonatomic)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

//用来标记每个大头针的属性
@property(nonatomic)NSInteger tag;
@end
