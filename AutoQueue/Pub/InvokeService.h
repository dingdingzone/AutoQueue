//
//  InvokeService.h
//  AutoQueue
//
//  Created by Lapland_Alone on 13-11-27.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface InvokeService : NSObject

+(NSString*) callService:(NSString*)param;

+(NSString*) callWebService:(NSString*)param;

+(NSString  *) getServiceResult:(NSString *)param;

- (void)requestFinished:(ASIHTTPRequest *)request;
@end
