//
//  ProSetting.m
//  AutoQueue
//
//  Created by leo on 13-12-20.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "ProSetting.h"

@implementation ProSetting

+(void)setNaviTitle:(NSString *)title :(UIViewController *)obj
{
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    t.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = UITextAlignmentCenter;
    t.text = title;
    obj.navigationItem.titleView = t;
}

+(UIColor *)getColorByStr:(NSString *)clrStr
{
    if([clrStr length] == 6)
    {
        NSString *redStr = [clrStr substringWithRange:NSMakeRange(0, 2)];
        NSString *greenStr = [clrStr substringWithRange:NSMakeRange(2, 2)];
        NSString *blueStr = [clrStr substringWithRange:NSMakeRange(4, 2)];
        UIColor *color = [[UIColor alloc] initWithRed:[ProSetting convertClrVal:redStr]/255.0 green:[ProSetting convertClrVal:greenStr]/255.0 blue:[ProSetting convertClrVal:blueStr]/255.0 alpha:1.0];
        return color;
    }
    else
    {
        UIColor *color = [[UIColor alloc] initWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0	];
        return color;
    }
}

+(int)convertClrVal:(NSString *)str
{
    if([str length] == 2)
    {
        double retVal = 0;
        for(int i = 0,n = [str length];i < n;i++)
        {
            char ch = [str characterAtIndex:i];
            switch (ch)
            {
                case 'a':
                case 'A':
                    retVal += pow(16,1-i)*10;
                    break;
                case 'b':
                case 'B':
                    retVal += pow(16,1-i)*11;
                    break;
                case 'c':
                case 'C':
                    retVal += pow(16,1-i)*12;
                    break;
                case 'd':
                case 'D':
                    retVal += pow(16,1-i)*13;
                    break;
                case 'e':
                case 'E':
                    retVal += pow(16,1-i)*14;
                    break;
                case 'f':
                case 'F':
                    retVal += pow(16,1-i)*15;
                    break;
                default:
                    retVal += pow(16,1-i)*(ch - 48);
                    break;
            }
        }
        return retVal;
    }
    else
    {
        return 255;
    }
}

+(float)getSysHeight:(UIView *)view
{
    return view.frame.size.height;
}

+(float)getScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

/*计算scrollView高度*/
+(float)getScrollViewHeight:(UIView *)view
{
    int YY=0;
    int HH=0;
    for(UIView * myView in view.subviews)
    {
        
        if ([myView isKindOfClass:[UIView class]])
        {
            int y=myView.frame.origin.y;
            int h=myView.frame.size.height;
            if(y>YY)
            {
                YY=y;
                HH=YY+h;
            }
        }
    }
    return HH;
}

+(void)setNaviLeftTitle:(NSString *)title color:(NSString *)colorStr obj:(UIViewController *)obj
{
    UILabel* titleLabel;
    titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(42.0f, 16.0f, 70.0f, 20.0f)];
    titleLabel.text = title;
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [ProSetting getColorByStr:colorStr];
    titleLabel.hidden=YES;
    [obj.navigationController.navigationBar addSubview: titleLabel];
}


@end
