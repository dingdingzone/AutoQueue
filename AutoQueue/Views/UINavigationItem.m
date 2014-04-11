//
//  NavigationController.m
//  AutoQueue
//
//  Created by alone on 13-11-20.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "UINavigationItem.h"

@interface UINavigationItem(Scale)

@end

@implementation UINavigationItem

-(UINavigationItem * ) changeStyle:(UINavigationItem*)item
{
    
    UIButton * backButton = [UIButton buttonWithType:100];
    
    [backButton setImage:[UIImage imageNamed:@"向左箭头.png"] forState:UIControlStateNormal];
    
    [backButton setBackgroundImage: [UIImage imageNamed:@"navigation.jpg"] forState:UIControlStateHighlighted];
    
    [backButton setBackgroundImage: [UIImage imageNamed:@"navigation.jpg"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToIndex) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem*icon =[[UIBarButtonItem alloc] initWithCustomView :backButton];
    
    item.leftBarButtonItem = icon;

    return item;
}

@end
