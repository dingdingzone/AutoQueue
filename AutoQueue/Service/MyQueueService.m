//
//  MyQueueService.m
//  AutoQueue
//
//  Created by leo on 13-12-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "MyQueueService.h"
#import "InvokeService.h"

@implementation MyQueueService

-(NSString *)getQueuedCount:(NSString *)userId
{
    NSString *param = [NSString stringWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10210\",securityCode:\"0000000000\",params:{userId:\"%@\"},rtnDataFormatType:\"user-defined\"}",userId];
    return [InvokeService getServiceResult:param];
}

@end
