//
//  UINavigationItem+custom.m
//  AutoQueue
//
//  Created by alone on 13-11-21.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "UINavigationItem+custom.h"

@implementation UINavigationItem (custom)

-(void) setUIBarButtonItem:(UINavigationItem*)item : (UIButton*) backButton;
{
    
    [backButton setImage:[UIImage imageNamed:@"向左箭头.png"] forState:UIControlStateNormal];
    
    //[backButton setBackgroundImage: [UIImage imageNamed:@"navigation.jpg"] forState:UIControlStateHighlighted];
    
    //[backButton setBackgroundImage: [UIImage imageNamed:@"navigation.jpg"] forState:UIControlStateNormal];
    
    UIBarButtonItem*icon =[[UIBarButtonItem alloc] initWithCustomView :backButton];
    
    item.leftBarButtonItem = icon;
    
}

- (void) setUIBarButtonTitle:(UINavigationItem *)item :(NSString *)title
{
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 120, 50)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:20.0]];
    [titleText setText:title];
    item.titleView = titleText;
    titleText.textAlignment = NSTextAlignmentCenter;
}

@end
