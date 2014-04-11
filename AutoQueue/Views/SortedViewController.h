//
//  SortedViewController.h
//  AutoQueue
//
//  Created by leo on 13-11-21.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueueAppDelegate.h"

@interface SortedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) QueueAppDelegate * myDelegate;

@end
