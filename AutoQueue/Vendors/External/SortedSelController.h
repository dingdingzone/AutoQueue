//
//  SortedSelController.h
//  AutoQueue
//
//  Created by leo on 13-12-30.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortedSelController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *queueTable;

-(IBAction)enterClick:(id)sender;

@end
