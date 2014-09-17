//
//  HuntFoodViewController.h
//  AutoQueue
//
//  Created by leon on 14-9-11.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import "QueueAppDelegate.h"
#import "MBProgressHUD.h"
#import "BaseViewController.h"
#import "MJRefresh.h"

#define SCREENSHOT_MODE 0

@interface HuntFoodViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    int num;
    BOOL upOrdown;
    bool reloading;
}

@property (nonatomic,retain) QueueAppDelegate * myDelegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void)reloadTableViewDataSource;

-(void)doneLoadingTableViewData;

-(void)loadingTableData;

-(void)freashTableView;

@end
