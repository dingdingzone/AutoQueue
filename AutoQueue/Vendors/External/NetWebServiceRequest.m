//
//  ServiceHelper.m
//  HttpRequest
//
//  Created by Richard Liu on 13-3-18.
//  Copyright (c) 2013年 Richard Liu. All rights reserved.
//

#import "NetWebServiceRequest.h"
#import "SoapXmlParseHelper.h"
#import "ASIDownloadCache.h"


NSString* const NetWebServiceRequestErrorDomain = @"NetWebServiceRequestErrorDomain";


@interface NetWebServiceRequest ()<ASIHTTPRequestDelegate>

@property (nonatomic, retain) __block ASIHTTPRequest* runningRequest;
@property (nonatomic, retain) NSRecursiveLock *cancelLock;

@end


@implementation NetWebServiceRequest
@synthesize runningRequest = _runningRequest;
@synthesize delegate = _delegate;
@synthesize cancelLock = _cancelLock;
@synthesize tag;




+ (id)serviceRequestUrl:(NSString *)WebURL
          SOAPActionURL:(NSString *)soapActionURL
      ServiceMethodName:(NSString *)strMethod
            SoapMessage:(NSString *)soapMsg
{
    return [[[self alloc] initWithUrl:WebURL SOAPActionURL:soapActionURL ServiceMethodName:strMethod SoapMessage:soapMsg] autorelease];
}






//创建请求对象
- (id)initWithUrl:(NSString *)WebURL SOAPActionURL:(NSString *)soapActionURL
                                 ServiceMethodName:(NSString *)strMethod
                                       SoapMessage:(NSString *)soapMsg

{
	//请求发送到的路径
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", WebURL]];
    
	if ((self = [super init])) {
        self.runningRequest = [[ASIHTTPRequest alloc] initWithURL:url];
      
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
        
        //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
        [self.runningRequest addRequestHeader:@"Host" value:[url host]];
        [self.runningRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
        [self.runningRequest addRequestHeader:@"Content-Length" value:msgLength];
        [self.runningRequest addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@",soapActionURL]];
        [self.runningRequest setRequestMethod:@"POST"];
        //传soap信息
        [self.runningRequest appendPostData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
        [self.runningRequest setValidatesSecureCertificate:NO];
        [self.runningRequest setTimeOutSeconds:30.0];
        [self.runningRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        
        
        self.runningRequest.delegate = self;
#ifdef SSL
        [self.runningRequest setValidatesSecureCertificate:NO];
#else
        [self.runningRequest setValidatesSecureCertificate:YES];
#endif
        
        
        self.cancelLock = [[NSRecursiveLock alloc]  init];
    }
	return self;
}


-(void)dealloc{
    [self cancel];

    [super dealloc];
}



- (BOOL)isCancelled
{
    return [self.runningRequest isCancelled];
}

- (BOOL)isExecuting
{
    return [self.runningRequest isExecuting];
}

- (BOOL)isFinished
{
    return [self.runningRequest isFinished];
}


- (void) setDelegate:(id)delegate
{

    [self.cancelLock lock];
    
    _delegate = delegate;
    
    [self.cancelLock unlock];

}

-(void) setDownCache:(ASIDownloadCache *)cache
{
    [self.runningRequest setDownloadCache:cache];
    [self.runningRequest setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
}

- (void)startAsynchronous
{
    NSLog(@"Url_path:%@",_runningRequest.url);
    NSLog(@"Method:%@",_runningRequest.requestMethod);
    [_runningRequest startAsynchronous];
}

- (void)startSynchronous
{
    NSLog(@"Url_path:%@",_runningRequest.url);
    NSLog(@"Method:%@",_runningRequest.requestMethod);
    [_runningRequest startSynchronous];
}

- (void) cancel
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
     [self.cancelLock lock];
    
    self.delegate = nil;
    
    if (self.runningRequest)
    {
        [self.runningRequest clearDelegatesAndCancel];
        self.runningRequest = nil;
    }
    
    [self.cancelLock unlock];
    

}


- (void)NetWebServiceRequestStarted
{
    if (_delegate && [_delegate respondsToSelector:@selector(netRequestStarted:)])
    {
        [self.delegate netRequestStarted:self];
    }
 
}



- (void)FinisheddidRecvedInfoToResult:(NSString *)result responseData:(NSData*)requestData
{

    if (_delegate && [_delegate respondsToSelector:@selector(netRequestFinished: finishedInfoToResult: responseData:)]) {
		[_delegate netRequestFinished:self finishedInfoToResult:result responseData:requestData];
	}
}

- (void) FaileddidRequestError:(NSError *)error
{
   NSLog(@"begin");
    
    if (_delegate && [_delegate respondsToSelector:@selector(netRequestFailed:didRequestError:)]) {
        [_delegate netRequestFailed:self didRequestError:error];
    }
  NSLog(@"end");
}




#pragma mark -
#pragma mark - ASIHTTPRequestDelegate Methods
- (void)requestStarted:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self NetWebServiceRequestStarted];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    int statusCode = [request responseStatusCode];
	NSString *soapAction = [[request requestHeaders] objectForKey:@"SOAPAction"];
    
    NSArray *arraySOAP =[soapAction componentsSeparatedByString:@"/"];
    int count = [arraySOAP count] - 1;
	NSString *methodName = [arraySOAP objectAtIndex:count];
    
 
	// Use when fetching text data
	NSString *responseString = [request responseString];
	NSString *result = nil;
    
    if (request.didUseCachedResponse)
    {
        NSLog(@"使用缓存数据");
    } else {
        NSLog(@"请求网络数据");
    }
    
    if (statusCode == 200)
    {
        //表示正常请求
        result = [SoapXmlParseHelper SoapMessageResultXml:responseString ServiceMethodName:methodName];

        NSData *responseData = [request responseData];
        [self FinisheddidRecvedInfoToResult:result responseData:responseData];
    }
    else
    {
        NSLog(@"error 1");
       // NSError *error;
        /*
        if (request.responseStatusMessage) {
            error = ERROR_INFO(NetWebServiceRequestErrorDomain, request.responseStatusCode,request.responseStatusMessage);
        }
        else {
            error = ERROR_NOINFO(NetWebServiceRequestErrorDomain, request.responseStatusCode);
        }
        
        CLog(@"error:%@",error);
        */
        //[self FaileddidRequestError:error];
    }
}



- (void)requestFailed:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"网络错误");

  /*
    NSError *error = ERROR_DICTINFO(NetWebServiceRequestErrorDomain, request.error.code, request.error.userInfo);
    
    if (error.code == ASIRequestTimedOutErrorType) {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestTimedOutErrorType, @"网络连接超时");
    }
    else if (error.code == ASIConnectionFailureErrorType)
    {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestConnectionFailureErrorType, @"未连接网络");
    }
    
    //网络错误
    [self FaileddidRequestError:error];
   */
	
}






@end
