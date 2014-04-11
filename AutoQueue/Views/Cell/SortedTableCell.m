//
//  SortedTableCell.m
//  AutoQueue
//
//  Created by leo on 13-12-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "SortedTableCell.h"

@implementation SortedTableCell

@synthesize sortedImg;
@synthesize sortedName;
@synthesize sortedAddr;
@synthesize sortedState;
@synthesize sortedType;
@synthesize sortedPos;
@synthesize sortedPosLab;
@synthesize bookBtn;

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
