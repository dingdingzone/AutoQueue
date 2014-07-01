//
//  QueueAppDelegate.h
//  AutoQueue
//
//  Created by alone on 13-11-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabViewController.h"
@interface QueueAppDelegate : UIResponder <UIApplicationDelegate>
{
    UITabBarController* tabBarViewController;
    TabViewController * tabView;
    UIViewController * topView ;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) id userObj;
@property (nonatomic,retain) NSString * userNameApp;
@property (nonatomic,retain) NSString * passWordApp;
@property (nonatomic,retain) UITabBarController* tabBarViewController;
@property (nonatomic,retain) TabViewController * tabView;
@property (nonatomic,retain)  UIViewController * topView ;
@end
