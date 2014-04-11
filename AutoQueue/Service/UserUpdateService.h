//
//  UserUpdateService.h
//  AutoQueue
//
//  Created by leo on 13-12-16.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserUpdateService : NSObject

- (NSString *) updateUserInfo:(NSString *)userId :(NSString *)userName :(NSString *)userPhone :(NSString *)passOld :(NSString *)passNew :(NSString *)passConfirm;

@end
