	//
//  StringUtil.m
//  AutoQueue
//
//  Created by leo on 13-12-2.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "StringUtil.h"
#import "TimerUtil.h"
#import "SelPickerView.h"
#import <QuartzCore/QuartzCore.h>

static UIActivityIndicatorView *indicator;

@implementation StringUtil

+ (bool) isNullString:(NSString *)argStr,...
{
    va_list vaList;
    va_start(vaList, argStr);
    NSString *str;
    if(argStr == false || argStr.length == 0)
    {
        return false;
    }
    while((str = va_arg(vaList , NSString *)))
    {
        str = [NSString stringWithFormat:@"%@" ,str];
        if(str == false || str.length == 0)
        {
            return false;
        }
    }
    va_end(vaList);
    return true;
}

+ (void) tipsInfo:(NSString *)title :(NSString *)content
{
    UIAlertView *uiAlertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [uiAlertView show];
}

+ (UIActivityIndicatorView *) loading:(UIViewController *)viewController
{
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, 0, 70, 60);
    [indicator setCenter:CGPointMake(viewController.view.frame.size.width/2, viewController.view.frame.size.height/2-50)];
    indicator.backgroundColor = UIColor.grayColor;
    indicator.alpha = 0.5;
    indicator.layer.cornerRadius = 6;
    indicator.layer.masksToBounds = YES;
    [viewController.view addSubview:indicator];
    [indicator startAnimating];
    return indicator;
}

+ (bool) checkIsNumber:(NSString *)numStr
{
    NSString *reg = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    return [predicate evaluateWithObject:numStr];
}

+(void)getImageView:(NSString *)url :(UIImageView *)imageView
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:url];
    [arr addObject:imageView];
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImage:) object:arr];
    [thread start];
}

+(void)loadImage:(NSMutableArray *)arr
{
    NSString *url = (NSString *)[arr objectAtIndex:0];
    UIImageView *imageView = (UIImageView *)[arr objectAtIndex:1];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:data];
    imageView.image = image;
}

+(void)showPickView:(NSString *)title :(NSMutableArray *)dataArr delegate:(UIViewController *)obj
{
    SelPickerView *selView = [[SelPickerView alloc] initWithTitle:@"请选择要取的号码种类" :dataArr delegate:obj];
    [selView showInView:obj.view];
}

+(bool)validatePhoneNum:(NSString *)phoneNum
{
    NSString *regExp = @"^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *preTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regExp];
    return [preTest evaluateWithObject:phoneNum];
}

@end
