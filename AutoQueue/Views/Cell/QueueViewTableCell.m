//
//  QueueViewTableCell.m
//  AutoQueue
//
//  Created by leo on 13-11-21.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "QueueViewTableCell.h"

@implementation QueueViewTableCell
@synthesize MerImage;
@synthesize MerName;
@synthesize MerAddr;
@synthesize MerGold;

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
