//
//  DoubleTableService.m
//  AutoQueue
//
//  Created by leo on 13-12-10.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "DoubleTableService.h"
#import "PubData.h"

@implementation DoubleTableService

@synthesize tableData;
@synthesize tableIndex;
@synthesize subTableData;
@synthesize subTableIndex;
@synthesize areaDataInfo;

- (void) getData
{
    areaDataInfo = [PubData getAreaInfo];
    tableData = [[NSMutableArray alloc] init];
    tableIndex = [[NSMutableArray alloc] init];
    subTableData = [[NSMutableArray alloc] init];
    subTableIndex = [[NSMutableArray alloc] init];
    NSMutableDictionary *dictMain = [self getMainAreaInfo:areaDataInfo];
    
    for(NSString *key in dictMain)
    {
        [tableData addObject:[dictMain objectForKey:key]];
        [tableIndex addObject:key];
    }
    
    NSMutableDictionary *dictSubMain = [self getSubAreaInfo:areaDataInfo :[tableIndex objectAtIndex:0]];
    for(NSString *key in dictSubMain)
    {
        [subTableData addObject:[dictSubMain objectForKey:key]];
        [subTableIndex addObject:key];
    }
}

-(NSMutableDictionary *)getMainAreaInfo:(NSMutableDictionary *)dataDict
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSEnumerator *enumerator = [dataDict objectEnumerator];
    id value = nil;
    while(value = [enumerator nextObject])
    {
        [dict setObject:[value objectForKey:@"paramDesc"] forKey:[value objectForKey:@"paramValue"]];
    }
    return dict;
}

-(NSMutableDictionary *)getSubAreaInfo:(NSMutableDictionary *)dataDict :(NSString *)key
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSEnumerator *enumerator = [dataDict objectEnumerator];
    id value = nil;
    while(value = [enumerator nextObject])
    {
        if([[value objectForKey:@"paramValue"] isEqual:key])
        {
            NSEnumerator *iterator = [[value objectForKey:@"subList"] objectEnumerator];
            id data;
            while(data = [iterator nextObject])
            {
                [dict setObject:[data objectForKey:@"paramDesc"] forKey:[data objectForKey:@"paramValue"]];
            }
            break;
        }
    }
    return dict;
}

-(void) getChangeSubAreaInfo:(int)row
{
    subTableData = nil;
    subTableIndex = nil;
    subTableData = [[NSMutableArray alloc] init];
    subTableIndex = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dictSubMain = [self getSubAreaInfo:areaDataInfo :[tableIndex objectAtIndex:row]];
    for(NSString *key in dictSubMain)
    {
        [subTableData addObject:[dictSubMain objectForKey:key]];
        [subTableIndex addObject:key];
    }
}

@end
