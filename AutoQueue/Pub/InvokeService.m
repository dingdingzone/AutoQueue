//
//  InvokeService.m
//  AutoQueue
//
//  Created by Lapland_Alone on 13-11-27.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "InvokeService.h"
#import "SoapXmlParseHelper.h"
#import "StringUtil.h"

//extern NSString* const url = @"http://133.0.179.151:7001/aqse/services/autoQueueService?wsdl";
extern NSString* const url = @"http://pay.hb.189.cn/aqse/services/autoQueueService?wsdl";
@implementation InvokeService
+(NSString*) callService:(NSString*)param
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
    
    
    NSString *soapActionURL = @"http://service.hbgz.com";
    NSURL * asiUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", url]];
    ASIHTTPRequest *request =[[ASIHTTPRequest alloc] initWithURL:asiUrl];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:msgLength];
    [request addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@",soapActionURL]];
    [request setRequestMethod:@"POST"];
    //传soap信息
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:60.0];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request startSynchronous];
    
    NSData *data  = [request responseData];
    if([request error] != nil)
    {
        //[StringUtil tipsInfo:@"网络错误" :@"您的网络设置有误"];
    }
    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    return result;
}

+(NSString  *) getServiceResult:(NSString *)param
{
    NSString *data = [self callService:param];
    NSString *result = [SoapXmlParseHelper SoapMessageResultXml:data ServiceMethodName:@"ns:return"];
    return result;
}

@end
