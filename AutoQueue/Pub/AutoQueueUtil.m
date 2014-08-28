//
//  AutoQueueUtil.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-7-4.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "AutoQueueUtil.h"
#import "NetWebServiceRequest.h"

@implementation AutoQueueUtil


+(NetWebServiceRequest *) initServiceRequest:(NSString *)param
{
    
    NSString *soapMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
							 "<soap:Body>\n"
							 "<autoQueueService xmlns=\"http://service.hbgz.com\">\n"
							 "<param>%@</param>\n"
							 "</autoQueueService>\n"
							 "</soap:Body>\n"
							 "</soap:Envelope>\n", param
							 ];
    
    NSString*  url = @"http://pay.hb.189.cn/aqse/services/autoQueueService?wsdl";
    NSString *soapActionURL = @"http://service.hbgz.com";
    NetWebServiceRequest * request = [NetWebServiceRequest serviceRequestUrl:url SOAPActionURL:soapActionURL ServiceMethodName:nil SoapMessage:soapMessage];

    return request;
}

+(NSString *) loginAction:(NSString *)userName :(NSString*) password
{
//        NSString *param = [[NSString alloc] initWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1022\",securityCode:\"0000000000\",params:{userName:\"%@\",password:\"%@\",userType:\"C\"},rtnDataFormatType:\"JSON\"}",userName,password];

     NSString *param = [[NSString alloc] initWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1022\",securityCode:\"0000000000\",params:{userName:\"18907181672\",password:\"Zhikh0B8cUs=\",userType:\"C\"},rtnDataFormatType:\"JSON\"}"];

    return param;
}


+ (NSString *) getMerchantInfoParam:(NSString *)merchantName :(NSString *)merchantType :(NSString *)merchantDetailType :(NSString *)province :(NSString *)city :(NSString *)area :(NSString *)businessDistrict :(NSString *)pageNum :(NSString *)pageSize
{
    
    NSString *param = [NSString stringWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10320\",securityCode:\"0000000000\",params:{pageNum:%@,pageSize:%@,merchantName:\"%@\",merchantType:\"%@\",merchantDetailType:\"%@\",province:\"%@\",city:\"%@\",area:\"%@\",businessDistrict:\"%@\",queueFlag:\"Y\",advertFlag:\"N\",receivedLevel:\"\",merchantLevel:\"\",onlineOrderFlag:\"\",GPSLatitude:\"\",GPSLongtude:\"\",userId:\"\"},rtnDataFormatType:\"user-defined\"}",pageNum,pageSize,merchantName,merchantType,merchantDetailType,province,city,area,businessDistrict];
    return param;
}
@end
