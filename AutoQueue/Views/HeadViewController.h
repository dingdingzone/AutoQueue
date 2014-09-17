//
//  HeadViewController.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-3-6.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PushViewDelegate <NSObject>

@optional
-(void) pushViewBySegue;
@end

@interface HeadViewController : UIViewController
-(IBAction)foodOnClick:(id)sender;
-(IBAction)queueOnClick:(id)sender;
-(IBAction)huntOnClick:(id)sender;

@property (assign, nonatomic) id<PushViewDelegate> delegate;
@end
