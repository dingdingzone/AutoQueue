//
//  LoginService.h
//  AutoQueue
//
//  Created by Lapland_Alone on 13-11-26.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWebServiceRequest.h"
#import "ASIHTTPRequest.h"
#import "InvokeService.h"
#import "QueueAppDelegate.h"

@interface LoginService : NSObject <NetWebServiceRequestDelegate>

@property (nonatomic, retain) NetWebServiceRequest * runningRequest;
@property (nonatomic, retain) ASIHTTPRequest * asiRequest;
@property (strong, nonatomic) NSMutableData *xmlData;

-(bool) userLogin:(NSString *) userName:(NSString*) password;
@property (nonatomic,retain) QueueAppDelegate * myDelegate;

@end
