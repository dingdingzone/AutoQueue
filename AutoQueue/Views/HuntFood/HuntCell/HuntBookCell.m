//
//  HuntBookCell.m
//  AutoQueue
//
//  Created by leon on 14-9-17.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "HuntBookCell.h"

@implementation HuntBookCell


@synthesize dishName;
@synthesize dishPrice;
@synthesize dishRecom;
@synthesize dishNum;

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
