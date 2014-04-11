//
//  User.h
//  AutoQueue
//
//  Created by leo on 13-11-27.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSDate *createTime;
    NSString *mobileNbr;
    NSString *status;
    NSString *userId;
    NSString *userName;
    NSString *userPassword;	
    NSString *userType;
}

@property(strong, nonatomic) NSString *mobileNbr;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *userName;
@property(strong, nonatomic) NSString *userPassword;	
@property(strong, nonatomic) NSString *userType;
@property(strong, nonatomic) NSDate *createTime;
@property(nonatomic) NSString *userId;

@end
