//
//  TimerUtil.m
//  AutoQueue
//
//  Created by leo on 13-12-3.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "TimerUtil.h"

static id timer;

@implementation TimerUtil

+(void) init:(NSString *)funcName :(int)tLong :(id)view
{
    SEL funcSel = NSSelectorFromString(funcName);
    timer = [NSTimer scheduledTimerWithTimeInterval:tLong target:view selector:@selector(funcSel) userInfo:nil repeats:YES];
}

-(void) tips:(id)atimer
{
    [atimer stopAnimating];
}

@end
