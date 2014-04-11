//
//  SortedService.h
//  AutoQueue
//
//  Created by leo on 13-12-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortedService : NSObject

-(int)getSortedInfoList:(NSString *)userId :(NSMutableArray *)arr;

-(NSString *)cancelBook:(NSString *)queueId :(NSString *)userId :(NSString *)mobileNbr;

@end


