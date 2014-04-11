//
//  QueueService.h
//  AutoQueue
//
//  Created by leo on 13-12-17.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueueService : NSObject

-(void) getMerchantInfo:(NSString *)merchantName :(NSString *)merchantType :(NSString *)merchantDetailType :(NSString *)province :(NSString *)city :(NSString *)area :(NSString *)businessDistrict :(NSMutableArray *)MerImageArr :(NSMutableArray *)MerNameArr :(NSMutableArray *)MerAddrArr :(NSMutableArray *)MerCountArr :(NSMutableArray *)MerIdArr :(NSString *)pageNum :(NSString *)pageSize;

@end
