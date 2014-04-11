//
//  SortedService.m
//  AutoQueue
//
//  Created by leo on 13-12-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "SortedService.h"
#import "InvokeService.h"
#import "SBJsonObj.h"
#import "SortedQueue.h"

@implementation SortedService

-(int)getSortedInfoList:(NSString *)userId :(NSMutableArray *)arr
{
    NSString *param = [NSString stringWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1028\",securityCode:\"0000000000\",params:{userId:\"%@\"},rtnDataFormatType:\"user-defined\"}",userId];
    NSString *result = [InvokeService getServiceResult:param];
    NSArray *resArr = [SBJsonObj fromArray:result];
    int cnt = 0;
    for(int i = 0,n = [resArr count];i < n;i++)
    {
        NSDictionary *dict = [resArr objectAtIndex:i];
        SortedQueue *sortedQueue = [SortedQueue alloc];
        sortedQueue.status = [dict objectForKey:@"status"];
        if([sortedQueue.status isEqualToString:@"等待中"])
        {
            cnt++;
        }
        sortedQueue.queueId = [dict objectForKey:@"queueId"];
        sortedQueue.userId = [dict objectForKey:@"userId"];
        sortedQueue.queueName = [dict objectForKey:@"queueName"];
        sortedQueue.addr = [dict objectForKey:@"addr"];
        sortedQueue.mobileNbr = [dict objectForKey:@"mobileNbr"];
        sortedQueue.merchantName = [dict objectForKey:@"merchantName"];
        sortedQueue.imageName = [dict objectForKey:@"imageName"];
        sortedQueue.queueSeq = [dict objectForKey:@"queueSeq"];
        sortedQueue.imageId = [dict objectForKey:@"imageId"];
        [arr addObject:sortedQueue];
    }
    return cnt;
}

-(NSString *)cancelBook:(NSString *)queueId :(NSString *)userId :(NSString *)mobileNbr
{
    NSString *param = [NSString stringWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1029\",securityCode:\"0000000000\",params:{queueId:\"%@\",userId:\"%@\",mobileNbr:\"%@\"},rtnDataFormatType:\"user-defined\"}",queueId,userId,mobileNbr];
    return [InvokeService getServiceResult:param];
}


@end
