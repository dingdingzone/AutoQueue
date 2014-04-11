//
//  SortedTableCell.h
//  AutoQueue
//
//  Created by leo on 13-12-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortedTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sortedImg;
@property (weak, nonatomic) IBOutlet UILabel *sortedName;
@property (weak, nonatomic) IBOutlet UILabel *sortedAddr;
@property (weak, nonatomic) IBOutlet UILabel *sortedType;
@property (weak, nonatomic) IBOutlet UILabel *sortedState;
@property (weak, nonatomic) IBOutlet UILabel *sortedPos;
@property (weak, nonatomic) IBOutlet UILabel *sortedPosLab;
@property (weak, nonatomic) IBOutlet UIButton *bookBtn;

@end
