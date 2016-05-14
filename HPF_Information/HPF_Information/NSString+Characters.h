//
//  NSString+Characters.h
//  HPF_Information
//
//  Created by XP on 16/5/13.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Characters)

//汉字转换为拼音
- (NSString *)pinyinOfName;

//汉字转换为拼音后，返回大写的首字母
- (NSString *)firstCharacterOfName;


@end
