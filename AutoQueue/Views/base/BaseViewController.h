//
//  BaseViewController.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-7-5.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "StringUtil.h"
#import "ProSetting.h"
#import "NetWebServiceRequest.h"
#import "AutoQueueUtil.h"
#import "SoapXmlParseHelper.h"
#import "SBJsonObj.h"

@interface BaseViewController : UIViewController<MBProgressHUDDelegate,NetWebServiceRequestDelegate>
{
    /*加载控件*/
    MBProgressHUD * HUD;
    long long expectedLength;
	long long currentLength;
    
   
}

/*调用webservice*/
@property (nonatomic, retain) NetWebServiceRequest* runningRequest;

- (void)myTask;
- (void)myProgressTask;
- (void)hudWasHidden:(MBProgressHUD *)hud;
-(void) shwoProgress;

@end
