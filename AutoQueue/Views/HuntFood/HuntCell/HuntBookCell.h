//
//  HuntBookCell.h
//  AutoQueue
//
//  Created by leon on 14-9-17.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuntBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dishName;
@property (weak, nonatomic) IBOutlet UILabel *dishPrice;
@property (weak, nonatomic) IBOutlet UILabel *dishRecom;
@property (weak, nonatomic) IBOutlet UILabel *dishNum;

@end
