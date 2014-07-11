//
//  DoubleTableController.h
//  FPPopoverDemo
//
//  Created by Lapland_Alone on 13-12-5.
//  Copyright (c) 2013年 Fifty Pixels Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class AKSegmentedControl;

@interface DoubleTableController : UIViewController


@property (assign, nonatomic) IBOutlet UITableView *parentTab;

@property (assign, nonatomic) IBOutlet UITableView *subTab;

@property(assign,nonatomic) AKSegmentedControl * delegate;

@end
