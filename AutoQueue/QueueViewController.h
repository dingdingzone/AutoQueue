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
#import "EGORefreshTableHeaderView.h"

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

@interface QueueViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableHeaderDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZBarReaderDelegate,CLLocationManagerDelegate>
{
    EGORefreshTableHeaderView *refreshHeaderView;
    CLLocationManager *locationManager;
    CSqlite *m_sqlite;
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    bool reloading;
}

@property (nonatomic, strong) UIImageView * line;
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchSeg;
@property (strong, nonatomic) IBOutlet UITextField *searchShop;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (strong,nonatomic) UINavigationController *navController;

@property (nonatomic,retain) QueueAppDelegate * myDelegate;

-(IBAction)loginClick:(id)sender;

-(IBAction)scanQR:(id)sender;

-(IBAction) searchPopClick:(id)sender;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
