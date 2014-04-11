//
//  ShopDetailService.h
//  AutoQueue
//
//  Created by leo on 13-12-17.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetailService : NSObject

-(void) getMerchantDetailInfo:(NSString *)merId :(NSMutableArray *)arr;

-(NSString *) getMerchantById:(NSString *)merId;

-(void) getQueueInfo:(NSString *)merId :(NSMutableArray *)arr;

-(NSString *)getQueueNum:(NSString *)queueId :(NSString *)merId :(NSString *)userId :(NSString *)mobileNbr;

@end
