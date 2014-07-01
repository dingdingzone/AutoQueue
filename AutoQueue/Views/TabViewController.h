//
//  TabViewController.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-3-27.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadViewController.h"

@interface TabViewController : UIViewController <PushViewDelegate>
{
    UITabBarController* tabBarViewController;
    UIViewController * topView ;
}
@end
