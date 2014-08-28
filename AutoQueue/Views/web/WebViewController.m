//
//  WebViewController.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-8-27.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

UIActivityIndicatorView * activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, 320, 568)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://demos.jquerymobile.com/1.0a4.1/"]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
     [webView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*网页开始加载的时候调用*/
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}

/*网页加载完成的时候调用*/
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"webViewDidFinishLoad");
}

/*网页加载错误的时候调用*/
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"didFailLoadWithError:%@", error);
}


// 如果返回NO，代表不允许加载这个请求
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    // 说明协议头是ios
//    if ([@"ios" isEqualToString:request.URL.scheme])
//    {
//        NSString *url = request.URL.absoluteString;
//        NSRange range = [url rangeOfString:@":"];
//        NSString *method = [request.URL.absoluteString substringFromIndex:range.location + 1];
//        
//        SEL selector = NSSelectorFromString(method);
//        
//        if ([self respondsToSelector:selector])
//        {
//            [self performSelector:selector];
//        }
//        
//        return NO;
//    }
//    
//    return YES;
//}

#pragma mark webview每次加载之前都会调用这个方法
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    
    if([urlComps count] && [[urlComps objectAtIndex:0]isEqualToString:@"objc"])
    {
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        if (1 == [arrFucnameAndParameter count])
        {
            // 没有参数
            if([funcStr isEqualToString:@"doFunc1"])
            {
                /*调用本地函数1*/
                NSLog(@"back");
                [self back];
                
            }
        }
        else if(2 == [arrFucnameAndParameter count])
        {
            //有参数的
            if([funcStr isEqualToString:@"doFunc1"] &&[arrFucnameAndParameter objectAtIndex:1])
            {
                /*调用本地函数1*/
                NSLog(@"doFunc1:parameter");
               
                NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.20.111:8080/MobileQueue/next.jsp"]];
          
                [webView loadRequest:request];
            }
        } 
        return NO; 
    }; 
    return YES; 
}

- (void)openCamera
{
    NSLog(@"打开了照相机");
}

#pragma mark 前进
- (void)forawrd {
    [webView goForward];
}
#pragma mark 后退
- (void)back {
    [webView goBack];
}
-(void) setA:(id)a b:(id)b c:(id)c
{
    NSLog(@"a");
}

+ (NSString *)webScriptNameForSelector:(SEL)selector

{
    
    if (selector == @selector(setA:b:c:)) {
        
        return @"setABC";
        
    }
    
    return nil;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
