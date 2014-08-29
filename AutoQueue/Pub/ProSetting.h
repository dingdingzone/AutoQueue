//
//  ProSetting.h
//  AutoQueue
//
//  Created by leo on 13-12-20.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProSetting : NSObject

+(void)setNaviTitle:(NSString *)title :(UIViewController *)obj;

+(UIColor *)getColorByStr:(NSString *)clrStr;

+(int)convertClrVal:(NSString *)str;

+(float)getSysHeight:(UIView *)view;

+(float)getScreenHeight;

+(float)getScrollViewHeight:(UIView *)view;

@end
