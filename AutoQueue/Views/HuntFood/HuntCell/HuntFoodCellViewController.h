//
//  HuntFoodCellViewController.h
//  AutoQueue
//
//  Created by leon on 14-9-11.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuntFoodCellViewController : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *MerImage;
@property (weak, nonatomic) IBOutlet UILabel *MerName;
@property (weak, nonatomic) IBOutlet UILabel *MerAddr;
@property (weak, nonatomic) IBOutlet UILabel *DistStr;

@end
