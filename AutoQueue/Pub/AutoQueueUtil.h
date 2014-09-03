//
//  AutoQueueUtil.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-7-4.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWebServiceRequest.h"
@interface AutoQueueUtil : NSObject

+(NetWebServiceRequest *) initServiceRequest:(NSString *)param;

+(NSString *) loginAction:(NSString *)userName :(NSString*) password;

+ (NSString *) getMerchantInfoParam:(NSString *)merchantName :(NSString *)merchantType :(NSString *)merchantDetailType :(NSString *)province :(NSString *)city :(NSString *)area :(NSString *)businessDistrict :(NSString *)pageNum :(NSString *)pageSize;

+(NSString *) getMerchantById:(NSString *)merId;
@end
