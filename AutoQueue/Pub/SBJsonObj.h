//
//  SBJsonObj.h
//  AutoQueue
//
//  Created by leo on 13-11-27.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBJsonObj : NSObject

+ (NSMutableArray *) fromArray:(NSString *)jsonStr;

+ (NSMutableDictionary *) fromDitionary:(NSString *)jsonStr;

+ (NSString *) getNodeStr:(NSString *)jsonStr :(NSString *)nodeName;

+ (NSString *) getStr:(NSString *)jsonStr :(NSString *)nodeName;

+ (id) toBean:(NSString *)jsonStr:(NSString *)beanName;

@end
