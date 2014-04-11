//
//  MyQueueController.h
//  AutoQueue
//
//  Created by alone on 13-11-20.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueueAppDelegate.h"

@interface MyQueueController : UIViewController<UIAlertViewDelegate>

-(IBAction)unLogin:(id)sender;

-(IBAction)selfQueueClick:(id)sender;

-(IBAction)queuedClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *queuePic;
@property (weak, nonatomic) IBOutlet UILabel *queueSeqLab;

@property (nonatomic,retain) QueueAppDelegate * myDelegate;

@end
