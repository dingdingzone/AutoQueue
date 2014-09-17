//
//  HuntFoodDetailViewController.h
//  AutoQueue
//
//  Created by leon on 14-9-15.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#include "BaseViewController.h"

@interface HuntFoodDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) NSString *merId;

-(IBAction)queueClick:(id)sender;

-(IBAction)queueEnterClick:(id)sender;

-(IBAction)queueCancelClick:(id)sender;

@end
