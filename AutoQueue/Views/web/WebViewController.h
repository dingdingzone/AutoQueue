//
//  WebViewController.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-8-27.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
{
 UIWebView *webView;  
}
- (void)openCamera;

@end
