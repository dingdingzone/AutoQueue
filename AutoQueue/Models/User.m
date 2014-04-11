//
//  User.m
//  AutoQueue
//
//  Created by leo on 13-11-27.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "User.h"
#import "ObjectMapping.h"

@implementation User

@synthesize mobileNbr;
@synthesize status;
@synthesize userName;
@synthesize userPassword;
@synthesize userType;
@synthesize createTime;
@synthesize userId;

- (ObjectMapping *)objectMapping {
    ObjectMapping *mapping = [ObjectMapping mappingForClass:[User class]];
    [mapping converEntityFromJsonToEntity:@"mobileNbr" to:@"mobileNbr" withClass: @"NSString"];
    [mapping converEntityFromJsonToEntity:@"status" to:@"status" withClass: @"NSString"];
    [mapping converEntityFromJsonToEntity:@"userName" to:@"userName" withClass: @"NSString"];
    [mapping converEntityFromJsonToEntity:@"userPassword" to:@"userPassword" withClass: @"NSString"];
    [mapping converEntityFromJsonToEntity:@"userType" to:@"userType" withClass: @"NSString"];
    [mapping converEntityFromJsonToEntity:@"userId" to:@"userId" withClass: @"NSString"];
    [mapping converEntityFromJsonToEntity:@"createTime" to:@"createTime" withClass: @"NSDate"];   
    return mapping;
}
@end
