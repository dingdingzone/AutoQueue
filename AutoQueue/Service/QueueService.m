//
//  QueueService.m
//  AutoQueue
//
//  Created by leo on 13-12-17.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "QueueService.h"
#import "StringUtil.h"
#import "SoapXmlParseHelper.h"
#import "InvokeService.h"
#import "PubData.h"


@implementation QueueService



-(void) getMerchantInfo:(NSString *)merchantName :(NSString *)merchantType :(NSString *)merchantDetailType :(NSString *)province :(NSString *)city :(NSString *)area :(NSString *)businessDistrict :(NSMutableArray *)MerImageArr :(NSMutableArray *)MerNameArr :(NSMutableArray *)MerAddrArr :(NSMutableArray *)MerCountArr :(NSMutableArray *)MerIdArr :(NSString *)pageNum :(NSString *)pageSize
{
    NSMutableDictionary *dict = [PubData getMerchantInfoJson:merchantName :merchantType :merchantDetailType :province :city :area :businessDistrict :pageNum :pageSize];
    NSEnumerator *enumerator = [dict objectEnumerator];
    id value;
    while(value = [enumerator nextObject])
    {
        [MerImageArr addObject:[value objectForKey:@"imageName"]];
        [MerNameArr addObject:[value objectForKey:@"merchantName"]];
        [MerAddrArr addObject:[value objectForKey:@"addr"]];
        [MerCountArr addObject:[value objectForKey:@"count"]];
        [MerIdArr addObject:[value objectForKey:@"merchantId"]];
    }
}





@end
