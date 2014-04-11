//
//  TabItemViewController.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-3-31.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavourViewController.h"
#import "HeadViewController.h"
@interface TabItemViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *myscrollview;
    FavourViewController * favourViewController;
    HeadViewController * headViewController;
}
@property (nonatomic,retain) UIScrollView *myscrollview;
@property (nonatomic,retain) FavourViewController * favourViewController;
@property (nonatomic,retain) HeadViewController * headViewController;

-(id)initWithViewController:(UIViewController*)viewController;

@end
