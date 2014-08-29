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
#import "QueueAppDelegate.h"
#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"

/*状态栏高度*/
#define  STATUS_BAR_H 20.0;

/*导航栏高度*/
#define  NAVIGATION_BAR_H 44.0;

/*屏幕第一UI控件起始高度*/
#define  STATUS_NAVI_H 32.0;

/*屏幕高度*/
#define SCREEN_HEIGHT [ProSetting getSysHeight:self.view];

/*屏幕内容高度*/
#define CONTENT_HEIGHT [ProSetting getSysHeight:self.view]-STATUS_NAVI_H;

/*热卖服务*/
#define HOT_SALES(str)  [@"BUS10320" isEqualToString:str];


@interface BaseViewController : UIViewController<MBProgressHUDDelegate,NetWebServiceRequestDelegate>
{
    /*加载控件*/
    MBProgressHUD * HUD;
    long long expectedLength;
	long long currentLength;
    QueueAppDelegate * appDelegate;
    NetWebServiceRequest* runningRequest;
    
}

/*调用webservice*/
@property (nonatomic, retain) NetWebServiceRequest* runningRequest;
@property (nonatomic,retain) QueueAppDelegate * appDelegate;


- (void)myTask;
- (void)myProgressTask;
- (void)hudWasHidden:(MBProgressHUD *)hud;
-(void) showProgress;

@end
