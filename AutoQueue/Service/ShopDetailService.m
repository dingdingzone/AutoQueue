//
//  ShopDetailService.m
//  AutoQueue
//
//  Created by leo on 13-12-17.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "ShopDetailService.h"
#import "InvokeService.h"
#import "SBJsonObj.h"
#import "StringUtil.h"
#import "Queue.h"

@implementation ShopDetailService

-(void) getMerchantDetailInfo:(NSString *)merId :(NSMutableArray *)arr
{
    NSString *result = [self getMerchantById:merId];
    if(result != nil && ![result isEqualToString:@""])
    {
        [arr removeAllObjects];
        NSMutableDictionary *dict = [SBJsonObj fromDitionary:result];
        [arr addObject:[dict objectForKey:@"merchantName"]];
        [arr addObject:[dict objectForKey:@"averageConsume"]];
        [arr addObject:[dict objectForKey:@"merchantType"]];
        [arr addObject:[dict objectForKey:@"queueCount"]];
        [arr addObject:[dict objectForKey:@"addr"]];
        [arr addObject:[dict objectForKey:@"contactNbr"]];
        [arr addObject:[dict objectForKey:@"discount"]];
        [arr addObject:[dict objectForKey:@"merchantDesc"]];
        [arr addObject:[dict objectForKey:@"openTime"]];
        [arr addObject:[dict objectForKey:@"imageInfo"]];
    }
}



-(void) getQueueInfo:(NSString *)merId :(NSMutableArray *)arr
{
    NSString *param = [NSString stringWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1033\",securityCode:\"0000000000\",params:{merchantId:\"%@\"},rtnDataFormatType:\"user-defined\"}",merId];
    NSString *result = [InvokeService getServiceResult:param];
    NSDictionary *dict = [SBJsonObj fromDitionary:result];
    NSEnumerator *enumerator = [dict objectEnumerator];
    id value;
    [arr removeAllObjects];
    while(value = [enumerator nextObject])
    {
        Queue *queue = [Queue alloc];
        queue.queueId = [value objectForKey:@"queueId"];
        queue.queueName = [value objectForKey:@"queueName"];
        queue.queueSeq = [value objectForKey:@"currentQueueSeq"];
        queue.queueCount = [value objectForKey:@"count"];
        [arr addObject:queue];
    }
}

-(NSString *)getQueueNum:(NSString *)queueId :(NSString *)merId :(NSString *)userId :(NSString *)mobileNbr
{
    NSString *param = [NSString stringWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1034\",securityCode:\"0000000000\",params:{queueId:\"%@\",merchantId:\"%@\",userId:\"%@\",mobileNbr:\"%@\"},rtnDataFormatType:\"user-defined\"}",queueId,merId,userId,mobileNbr];
    return [InvokeService getServiceResult:param];
}

@end
