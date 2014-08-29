//
//  SBJsonObj.m
//  AutoQueue
//
//  Created by leo on 13-11-27.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "SBJsonObj.h"
#import "SBJson.h"
#import "ObjectMappingObj.h"

@implementation SBJsonObj

+ (NSMutableArray *) fromArray:(NSString *)jsonStr
{
    SBJsonParser *jsonParse = [[SBJsonParser alloc] init];
    return [jsonParse objectWithString:jsonStr];
}

+ (NSMutableDictionary *) fromDitionary:(NSString *)jsonStr
{
    SBJsonParser *jsonParse = [[SBJsonParser alloc] init];
    return [jsonParse objectWithString:jsonStr];
}

+ (NSString *) getNodeStr:(NSString *)jsonStr :(NSString *)nodeName
{
    NSMutableDictionary *jsonDict = [self fromDitionary:jsonStr];
    [jsonDict objectForKey:nodeName];
    return [[jsonDict objectForKey:nodeName] JSONRepresentation];
}

+ (NSString *) getStr:(NSString *)jsonStr :(NSString *)nodeName
{
    NSMutableDictionary *jsonDict = [self fromDitionary:jsonStr];
    return[jsonDict objectForKey:nodeName];
}

+ (id) toBean:(NSString *)jsonStr:(NSString *)beanName
{
    NSMutableDictionary *dict = [self fromDitionary:jsonStr];
    return [ObjectMappingLoader loadObjectWithClassName:beanName andData:dict];
}


@end
