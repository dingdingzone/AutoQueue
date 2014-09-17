//
//  HuntFoodCellViewController.m
//  AutoQueue
//
//  Created by leon on 14-9-11.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "HuntFoodCellViewController.h"

@implementation HuntFoodCellViewController

@synthesize MerImage;
@synthesize MerName;
@synthesize MerAddr;
@synthesize DistStr;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
