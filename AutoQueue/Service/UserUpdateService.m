//
//  UserUpdateService.m
//  AutoQueue
//
//  Created by leo on 13-12-16.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "UserUpdateService.h"
#import "InvokeService.h"
#import "StringUtil.h"

@implementation UserUpdateService

- (NSString *) updateUserInfo:(NSString *)userId :(NSString *)userName :(NSString *)userPhone :(NSString *)passOld :(NSString *)passNew :(NSString *)passConfirm
{
    NSString *param = [NSString stringWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1023\",securityCode:\"0000000000\",params:{userId:\"%@\",userName:\"%@\",mobileNbr:\"%@\",oldPassword:\"%@\",password:\"%@\"},rtnDataFormatType:\"user-defined\"}",userId,userName,userPhone,passOld,passNew];
    return [InvokeService getServiceResult:param];
}

@end
