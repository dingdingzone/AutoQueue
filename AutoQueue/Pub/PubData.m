//
//  PubData.m
//  AutoQueue
//
//  Created by leo on 13-12-10.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "PubData.h"
#import "InvokeService.h"
#import "SBJsonObj.h"
#import "SoapXmlParseHelper.h"

@implementation PubData

+ (NSMutableDictionary *)getAreaInfo
{
    NSString *param = @"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1011\",securityCode:\"0000000000\",params:{paramType:\"AREA_DEFINATION\"},rtnDataFormatType:\"user-defined\"}";
    
    NSLog(@"Start GetArea");
    NSString *result = [InvokeService callService:param];
    
//    NSString *jsonStr = [SoapXmlParseHelper SoapMessageResultXml:result ServiceMethodName:@"ns:return"];
    
    NSMutableDictionary *retVal = [SBJsonObj fromDitionary:result];
    
    return retVal;
}
 + (NSMutableDictionary *) getMerchantInfoJson:(NSString *)merchantName :(NSString *)merchantType :(NSString *)merchantDetailType :(NSString *)province :(NSString *)city :(NSString *)area :(NSString *)businessDistrict :(NSString *)pageNum :(NSString *)pageSize
{
    NSString *param = [NSString stringWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10320\",securityCode:\"0000000000\",params:{pageNum:%@,pageSize:%@,merchantName:\"%@\",merchantType:\"%@\",merchantDetailType:\"%@\",province:\"%@\",city:\"%@\",area:\"%@\",businessDistrict:\"%@\",queueFlag:\"Y\",advertFlag:\"N\",receivedLevel:\"\",merchantLevel:\"\",onlineOrderFlag:\"\",GPSLatitude:\"\",GPSLongtude:\"\",userId:\"\"},rtnDataFormatType:\"JSON\"}",pageNum,pageSize,merchantName,merchantType,merchantDetailType,province,city,area,businessDistrict];
    NSString *data = [InvokeService callService:param];
//  NSString *result = [SoapXmlParseHelper SoapMessageResultXml:data ServiceMethodName:@"ns:return"];
    NSString * jsonStr = [SBJsonObj getNodeStr:data :@"merchantList"];
    return [SBJsonObj fromDitionary:jsonStr];
}

@end
