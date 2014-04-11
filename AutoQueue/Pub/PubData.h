//
//  PubData.h
//  AutoQueue
//
//  Created by leo on 13-12-10.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PubData : NSObject

+ (NSMutableDictionary *)getAreaInfo;

+ (NSMutableDictionary *) getMerchantInfoJson:(NSString *)merchantName :(NSString *)merchantType :(NSString *)merchantDetailType :(NSString *)province :(NSString *)city :(NSString *)area :(NSString *)businessDistrict :(NSString *)pageNum :(NSString *)pageSize;
@end
