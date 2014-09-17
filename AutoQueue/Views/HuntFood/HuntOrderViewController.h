//
//  HuntOrderViewController.h
//  AutoQueue
//
//  Created by leon on 14-9-17.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "BaseViewController.h"
#import "SMVerticalSegmentedControl.h"

@interface HuntOrderViewController : BaseViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *eatTime;
@property (weak, nonatomic) IBOutlet UILabel *ChoSeat;
@property (weak, nonatomic) IBOutlet UILabel *ChoDish;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (nonatomic, retain) SMVerticalSegmentedControl *orderSegmentedControl;
@property (nonatomic, retain) UIScrollView *orderScrollView;
@property (nonatomic, retain) SMVerticalSegmentedControl *bookSegmentedControl;
@property (nonatomic, retain) UIScrollView *bookScrollView;
@property (nonatomic, retain) NSArray *orderDataList;
@property (nonatomic, retain) UITableView *orderTableView;
@property (nonatomic, retain) NSArray *bookDataList;
@property (nonatomic, retain) UITableView *bookTableView;

-(IBAction)enterClick:(id)sender;

@end
