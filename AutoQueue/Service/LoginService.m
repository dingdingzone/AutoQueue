		//
//  LoginService.m
//  AutoQueue
//
//  Created by Lapland_Alone on 13-11-26.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "LoginService.h"
#import "NetWebServiceRequest.h"
#import "ASIHTTPRequest.h"
#import "SoapXmlParseHelper.h"
#import "SBJsonObj.h"
#import "User.h"

@implementation LoginService

@synthesize runningRequest = _runningRequest;
@synthesize asiRequest;
@synthesize xmlData;
@synthesize myDelegate;

-(bool) userLoginSA:(NSString *) userName:(NSString*) password
{
//    NSString *param = [[NSString alloc] initWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1022\",securityCode:\"0000000000\",params:{userName:\"%@\",password:\"%@\",userType:\"C\"},rtnDataFormatType:\"JSON\"}",userName,password];
  	
    NSString *param = [[NSString alloc] initWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1022\",securityCode:\"0000000000\",params:{userName:\"18907181672\",password:\"Zhikh0B8cUs=\",userType:\"C\"},rtnDataFormatType:\"JSON\"}"];
    
    NSString *result = [InvokeService callService:param];
    
    NSString *jsonStr = [SoapXmlParseHelper SoapMessageResultXml:result ServiceMethodName:@"ns:return"];
    
    NSString *returnMsgStr = [SBJsonObj getNodeStr:jsonStr :@"returnMsg"];
    
    NSLog(@"%@" , jsonStr);
    
    //NSString *returnMsgStr = @"{\"createTime\":{\"date\":19,\"day\":2,\"hours\":11,\"minutes\":25,\"month\":10,\"nanos\":0,\"seconds\":42,\"time\":1384831542000,\"timezoneOffset\":-480,\"year\":113},\"mobileNbr\":\"18907181052\",\"status\":\"N\",\"userId\":70441,\"userName\":\"18907181052\",\"userPassword\":\"FE59AE6B341E1F5214F5186750CDB8501A9CD018CF76D6EBF7E95693\",\"userType\":\"C\"}";
        
    id obj = [SBJsonObj toBean:returnMsgStr :@"User"];
    if (obj != nil) 
    {
        myDelegate = [[UIApplication sharedApplication] delegate];
        myDelegate.userObj = obj;
        return true;
    }else{
        return false;
    }
    
}

-(bool) userLogin:(NSString *) userName:(NSString*) password
{
    NSString *param = [[NSString alloc] initWithFormat:@"{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1022\",securityCode:\"0000000000\",params:{userName:\"18907181672\",password:\"Zhikh0B8cUs=\",userType:\"C\"},rtnDataFormatType:\"JSON\"}"];
    
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
    
    [request startAsynchronous];
    [request setDelegate:self];
    self.runningRequest = request;
    
}


- (void)netRequestStarted:(NetWebServiceRequest *)request
{
    NSLog(@"Start");
}


- (void)netRequestFinished:(NetWebServiceRequest *)request finishedInfoToResult:(NSString *)result responseData:(NSData *)requestData
{
    
    NSLog(@"result");
    NSString *resultt = [[NSString alloc] initWithData:requestData  encoding:NSUTF8StringEncoding];
    NSLog(@"%@",resultt);
    
}

/*
- (void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error{
    NSLog(@"%@",error);
 //方法1.
 05
 string = [NSString initWithFormat:@"%@,%@", string1, string2 ];
 06
 
 07
 //方法2.
 08
 string = [string1 stringByAppendingString:string2];
 09
 
 10
 //方法3 .
 11
 string = [string stringByAppendingFormat:@"%@,%@",string1, string2];
 }
*/

@end
