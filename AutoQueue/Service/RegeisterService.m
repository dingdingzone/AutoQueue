//
//  RegeisterService.m
//  AutoQueue
//
//  Created by leo on 13-12-17.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "RegeisterService.h"
#import "InvokeService.h"
#import "SoapXmlParseHelper.h"


@implementation RegeisterService


- (NSString *)regUser:(NSString *)regPhone :(NSString *)regValiCode
{
    NSString *param = [NSString stringWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1021\",securityCode:\"0000000000\",params:{userName:\"%@\",password:\"%@\",userType:\"C\"},rtnDataFormatType:\"user-defined\"}",regPhone,regValiCode];
    NSString *data = [InvokeService callService:param];
    NSString *result = [SoapXmlParseHelper SoapMessageResultXml:data ServiceMethodName:@"ns:return"];
    return result;
}
@end
