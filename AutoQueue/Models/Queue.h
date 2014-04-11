//
//  Queue.h
//  AutoQueue
//
//  Created by leo on 13-12-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

@property (nonatomic, strong) NSString *queueId;
@property (nonatomic, strong) NSString *queueName;
@property (nonatomic, strong) NSString *queueSeq;
@property (nonatomic, strong) NSString *queueCount;

@end
