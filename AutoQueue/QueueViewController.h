//
//  QueueViewController.h
//  AutoQueue
//
//  Created by alone on 13-11-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CSqlite.h"
#import <CoreLocation/CoreLocation.h>
#import "ZBarSDK.h"
#import "ShopDetailViewController.h"
#import "QueueAppDelegate.h"
#import "MBProgressHUD.h"
#import "BaseViewController.h"
#import "MJRefresh.h"

#define SCREENSHOT_MODE 0

@protocol MainTopBarDelegate <NSObject>


- (void) hiddenTopBar;


@end

@interface POI : NSObject <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *subtitle;
    NSString *title;
}

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic,retain) NSString *title;

-(id) initWithCoords:(CLLocationCoordinate2D) coords;

@end

@interface QueueViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZBarReaderDelegate,CLLocationManagerDelegate,MBProgressHUDDelegate>
{
    CLLocationManager *locationManager;
    CSqlite *m_sqlite;
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    bool reloading;
    id<MainTopBarDelegate>topBarDelegate;
}

@property (nonatomic, strong) UIImageView * line;
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchSeg;
@property (strong, nonatomic) IBOutlet UITextField *searchShop;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (strong,nonatomic) UINavigationController *navController;

@property (nonatomic,retain) QueueAppDelegate * myDelegate;
@property (retain, nonatomic) id<MainTopBarDelegate> topBarDelegate;
-(IBAction)loginClick:(id)sender;

-(IBAction)scanQR:(id)sender;

-(IBAction) searchPopClick:(id)sender;

- (void)reloadTableViewDataSource;

- (void)doneLoadingTableViewData;

-(void)loadingTableData;

-(void) freashTableView;

@end
