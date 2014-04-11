//
//  TimerUtil.h
//  AutoQueue
//
//  Created by leo on 13-12-3.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerUtil : NSObject

+(void) init:(NSString *)funcName :(int)tLong;

-(void) tips:(id)atimer;

@end
