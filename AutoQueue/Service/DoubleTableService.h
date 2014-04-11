//
//  DoubleTableService.h
//  AutoQueue
//
//  Created by leo on 13-12-10.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubleTableService : NSObject

@property NSMutableArray *tableData;
@property NSMutableArray *tableIndex;
@property NSMutableArray *subTableData;
@property NSMutableArray *subTableIndex;
@property NSMutableDictionary *areaDataInfo;

- (void) getData;

- (NSMutableDictionary *)getMainAreaInfo:(NSMutableDictionary *)dataDict;

- (NSMutableDictionary *)getSubAreaInfo:(NSMutableDictionary *)dataDict :(NSString *)key;

-(void) getChangeSubAreaInfo:(int)row;

@end
