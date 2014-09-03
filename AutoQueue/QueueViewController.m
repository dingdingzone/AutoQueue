//
//  QueueViewController.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-04-11.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "QueueViewController.h"
#import "QRViewController.h"
#import "QueueViewTableCell.h"
#import "SoapXmlParseHelper.h"
#import "DoubleTableController.h"
#import "FPPopoverController.h"
#import "AKSegmentedControl.h"
#import "QueueService.h"
#import "StringUtil.h"
#import "User.h"
#import "ProSetting.h"
#import "TopBarViewController.h"

#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"

@interface QueueViewController ()


@end

@implementation QueueViewController

QueueService *queueService;

NSMutableArray *MerImageArr;
NSMutableArray *MerNameArr;
NSMutableArray *MerAddrArr;
NSMutableArray *MerCountArr;
NSMutableArray *MerIdArr;
NSMutableDictionary *areaDataInfo;
User *userObj;
UIImageView *barView;
UIImageView *posImgView;
UILabel *coordLabel;

/*分页页数*/
int posNum;

@synthesize tableView;
@synthesize loginBtn;
@synthesize searchShop;
@synthesize searchSeg;
@synthesize myDelegate;
@synthesize topBarDelegate;

NSString *const MJTableViewCellIdentifier = @"Cell";

AKSegmentedControl * segmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    posNum =1;
    
    // 1.注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MJTableViewCellIdentifier];
    
    // 2.集成刷新控件
    [self setupRefresh];
    
    MerImageArr = [[NSMutableArray alloc] init];
    MerNameArr = [[NSMutableArray alloc] init];
    MerAddrArr = [[NSMutableArray alloc] init];
    MerCountArr = [[NSMutableArray alloc] init];
    MerIdArr = [[NSMutableArray alloc] init];
    
    
    searchShop.delegate = self;
    myDelegate = [[UIApplication sharedApplication] delegate];
    userObj = myDelegate.userObj;
    
    segmentedControl = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(-1.0,63.0,322.0, 35.0)];
    
    segmentedControl=[segmentedControl setupSegmentedControl:segmentedControl];
    
    // [segmentedControl setDelegate:self];
    
    segmentedControl.queueViewController=self;
    [self.view addSubview:segmentedControl];
    
    self.view.layer.backgroundColor = [UIColor grayColor].CGColor;
    
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"放大镜.png"]];
    image.frame = CGRectMake(0, 0, 16, 16);
    
    searchShop.leftView=image;
    searchShop.leftViewMode = UITextFieldViewModeAlways;
    searchShop.placeholder = @"搜索排队";
    
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation.jpg"] forBarMetrics:UIBarMetricsDefault];
        //[SELF.navigationController.navigationBar SET]
    }
   
	// Do any additional setup after loading the view, typically from a nib.
    self.view.layer.backgroundColor = [ProSetting getColorByStr:@"f5f5f5"].CGColor;
    
    
    coordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 97, 322.0, 25.0)];
    UIImage *posImage = [UIImage imageNamed:@"local_erea_img.png"];
    posImgView = [[UIImageView alloc]initWithImage:posImage];
    posImgView.frame = CGRectMake(4, 101, 12, 20);
    coordLabel.backgroundColor = [ProSetting getColorByStr:@"f5f5f5"];
    
    //[self locationPosition];GPS
    [self loadingTableData];
    
    [self controlTopBarDisplay:NO];
    
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    #warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark ---------------------开始进入刷新状态
- (void)headerRereshing
{
    // 1.加载数据
    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    // 刷新表格
    [self.tableView reloadData];
        
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.加载数据
    [self loadingTableData];
    // 2.2秒后刷新表格UI
//      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView footerEndRefreshing];
//    });
}




#pragma mark-------------------刷新tableview
-(void) freashTableView
{
   
    queueService=[QueueService alloc];
    [queueService getMerchantInfo:@"" :@"" :@"" :@"" :@"" :@"" :@"" :MerImageArr :MerNameArr :MerAddrArr :MerCountArr :MerIdArr :[NSString stringWithFormat:@"%d",posNum] :@"5"];
    posNum++;
    [tableView reloadData];

}

#pragma mark -----------------------------调用webservice服务组件
/*加载tableview数据*/
-(void)loadingTableData
{
    int h=STATUS_NAVI_H;
    int listHeight=CONTENT_HEIGHT;
    
    tableView.frame = CGRectMake(tableView.frame.origin.x , h, tableView.frame.size.width , listHeight);
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setTableFooterView:v];
    
    /*获取调用webservice服务入参*/
    NSString * param = [AutoQueueUtil getMerchantInfoParam:@"" :@"" :@"" :@"" :@"" :@"" :@"":[NSString stringWithFormat:@"%d",posNum] :@"10"];
    posNum++;
    
    /*获取服务实例*/
    NetWebServiceRequest * request =[AutoQueueUtil  initServiceRequest:param];
    
    /*缓存设置*/
    //  [request setDownCache:appDelegate.appCache];
    
    /*异步设置*/
    [request startAsynchronous];
    
    [request setDelegate:self];
    
    self.runningRequest = request;
}


/*开始异步请求数据tableview*/
- (void)netRequestStarted:(NetWebServiceRequest *)request
{
//   [self showProgress];
    NSLog(@"Start");
}

/*结束异步请求数据tableview*/
- (void)netRequestFinished:(NetWebServiceRequest *)request finishedInfoToResult:(NSString *)result responseData:(NSData *)requestData
{
    NSLog(@"Result");
    NSString *resultMsg = [[NSString alloc] initWithData:requestData  encoding:NSUTF8StringEncoding];
    
    NSString *jsonStr = [SoapXmlParseHelper SoapMessageResultXml:resultMsg ServiceMethodName:@"ns:return"];
    
    /*服务调用执行结果标示*/
    NSString * executeType=[SBJsonObj getStr:jsonStr :@"executeType"];
    
    /*服务请求ID*/
    NSString * serviceCode=[SBJsonObj getStr:jsonStr :@"serviceCode"];

    /*服务调用返回结果*/
    NSString *returnMsg =  [SBJsonObj getNodeStr:jsonStr :@"returnMsg"];
   
    /*判断调用服务类型，用于处理不同服务返回值*/
    BOOL isequal = HOT_SALES(serviceCode);

    if (isequal)
    {
        NSString *returnMsgStr = [SBJsonObj getNodeStr:returnMsg :@"merchantList"];
        
        NSMutableDictionary *dict = [SBJsonObj fromDitionary:returnMsgStr];
        NSEnumerator *enumerator = [dict objectEnumerator];
        id value;
        while(value = [enumerator nextObject])
        {
            [MerImageArr addObject:[value objectForKey:@"imageName"]];
            [MerNameArr  addObject:[value objectForKey:@"merchantName"]];
            [MerAddrArr  addObject:[value objectForKey:@"addr"]];
            [MerCountArr addObject:[value objectForKey:@"queueUserNum"]];
            [MerIdArr    addObject:[value objectForKey:@"merchantId"]];
        }
        
        [tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
        [self hudWasHidden:HUD];//结束进度条
    }
}


#pragma mark ------------------------------结束调用webservice服务组件
/*异步请求数据失败tableview*/
- (void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error
{
    NSLog(@"%@",error);
}


#pragma mark -----------------控制topbar的item显示
-(void) controlTopBarDisplay:(Boolean *)flag
{
    for(UIView * myView in self.navigationController.navigationBar.subviews)
    {
        //        if ([myView isKindOfClass:[UIView class]])
        //        {
        //            [myView removeFromSuperview];
        //        }
        if(myView.tag==1 || myView.tag==4)
        {
            myView.hidden=flag;
        }
        else if(myView.tag==2 || myView.tag==3 || myView.tag==4 || myView.tag==5 || myView.tag==6 || myView.tag==7)
        {
             myView.hidden=!flag;
            //              [myView removeFromSuperview];
            //              for (UIView* next = myView; next; next = next.superview)
            //              {
            //                  UIResponder* nextResponder = [next nextResponder];
            //                  if ([nextResponder isKindOfClass:[TopBarViewController class]])
            //                  {
            //                        topBarDelegate=nextResponder;
            //                        TopBarViewController * top=nextResponder;
            //                        [top  hiddenTopBar];
            //                        break;
            //                  }
            //              }
            
        }
    }
}





-(IBAction)loginClick:(id)sender
{
    if(userObj != nil)
    {
        [self performSegueWithIdentifier:@"segue_logged" sender:self];
    }
    else
    {
         [self controlTopBarDisplay:YES];
//        TopBarViewController* topView = [TopBarViewController alloc];
//        topView.view.tag=10000;
//        [self.navigationController.navigationBar addSubview: topView.view];
        
        [self.navigationController popViewControllerAnimated:YES];
        //        UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"TabBarStoryboard" bundle:nil];
        //        self.view.window.rootViewController=[stryBoard instantiateInitialViewController];
        // [self.navigationController pushViewController:stryBoard animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [MerNameArr count];
}

#pragma mark-----------------初始化TableView cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *queueTableIdentifier = @"queueCell";
    QueueViewTableCell *cell = (QueueViewTableCell *)[self.tableView dequeueReusableCellWithIdentifier:queueTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"queueCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.MerName.text = [MerNameArr objectAtIndex:indexPath.row];
    NSString *url = [MerImageArr objectAtIndex:indexPath.row];
    if(![url isEqualToString:@""])
    {
        [StringUtil getImageView:[MerImageArr objectAtIndex:indexPath.row] :cell.MerImage];
    }
    else
    {
        UIImage *image = [UIImage imageNamed:@"default_loading_img.png"];
        cell.MerImage.image = image;
    }
    cell.MerAddr.text = [MerAddrArr objectAtIndex:indexPath.row];
    //cell.MerCount.text = [NSString stringWithFormat:@"%@",[MerCountArr objectAtIndex:indexPath.row]];
    cell.MerGold.frame  = CGRectMake([cell.MerName.text length]*15+89, 6, 16, 16);
    return cell;
}


-(IBAction)scanQR:(id)sender
{
    if(IOS7)
    {
        QRViewController * rt = [[QRViewController alloc]init];
        [self presentViewController:rt animated:YES completion:^{
            
        }];
        
    }
    else
    {
        [self scanBtnAction];
    }
}

-(void)locationPosition
{
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=0.5;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation]; // 开始定位
    }
    
    NSLog(@"GPS 启动");
}

// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D mylocation = newLocation.coordinate;//手机GPS
    NSString *lat,*llong;
    lat = [[NSString alloc]initWithFormat:@"%d",(int)mylocation.latitude];
    llong = [[NSString alloc]initWithFormat:@"%d",(int)mylocation.longitude];
    NSLog(@"%@ %@",lat,llong);
    coordLabel.text = [NSString stringWithFormat:@"    %@,%@",lat,llong];
    /////////获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks,NSError *error)
     {
         if (placemarks.count >0   )
         {
             CLPlacemark * plmark = [placemarks objectAtIndex:0];
             
             NSString * country = plmark.country;
             NSString * city    = plmark.locality;
             
             
             NSLog(@"%@-%@-%@",country,city,plmark.name);
             NSLog(@"%@",placemarks);
             if(placemarks != nil)
             {
                 coordLabel.text = [NSString stringWithFormat:@"    %@-%@-%@",country,city,plmark.name];
             }
         }
         

         
     }];
    [self.view addSubview:coordLabel];
    [self.view addSubview:posImgView];
    //[geocoder release];
    
}
// 定位失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}

-(void)scanBtnAction
{
    num = 0;
    upOrdown = NO;
    //初始话ZBar
    ZBarReaderViewController * reader = [ZBarReaderViewController new];
    //设置代理
    reader.readerDelegate = self;
    //支持界面旋转
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.showsHelpOnFail = NO;
    reader.scanCrop = CGRectMake(0.1, 0.2, 0.8, 0.8);//扫描的感应框
    ZBarImageScanner * scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25
                   config:ZBAR_CFG_ENABLE
                       to:0];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    view.backgroundColor = [UIColor clearColor];
    reader.cameraOverlayView = view;
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    label.text = @"请将扫描的二维码至于下面的框内\n谢谢！";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.lineBreakMode = 0;
    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    image.frame = CGRectMake(20, 80, 280, 280);
    [view addSubview:image];
    
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [image addSubview:_line];
    //定时器，设定时间过1.5秒，
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    [self presentViewController:reader animated:YES completion:^{
        
    }];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (2*num == 260) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [timer invalidate];
    _line.frame = CGRectMake(30, 10, 220, 2);
    num = 0;
    upOrdown = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [timer invalidate];
    _line.frame = CGRectMake(30, 10, 220, 2);
    num = 0;
    upOrdown = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //初始化
        ZBarReaderController * read = [ZBarReaderController new];
        //设置代理
        read.readerDelegate = self;
        CGImageRef cgImageRef = image.CGImage;
        ZBarSymbol * symbol = nil;
        id <NSFastEnumeration> results = [read scanImage:cgImageRef];
        for (symbol in results)
        {
            break;
        }
        NSString * result;
        if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
            
        {
            result = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        else
        {
            result = symbol.data;
        }
        
        
        NSLog(@"%@",result);
        
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showShopDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ShopDetailViewController * detailViewController = segue.destinationViewController;
        detailViewController.MerId = [MerIdArr objectAtIndex:indexPath.row];
    }
}

-(IBAction) searchPopClick:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation POI

@synthesize coordinate,subtitle,title;

- (id) initWithCoords:(CLLocationCoordinate2D) coords{
    
    self = [super init];
    
    if (self != nil) {
        
        coordinate = coords;
        
    }
    
    return self;
    
}

@end

//[loginBtn setBackgroundImage:[UIImage imageNamed:@"用户.png"] forState:UIControlStateNormal];

/*
 UIImage * image = [UIImage imageNamed:@"向左箭头.png" ];
 UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
 UIBarButtonItem*icon =[[UIBarButtonItem alloc] initWithCustomView :imageView];
 self.navigationItem.leftBarButtonItem = icon;
 self.navigationItem.leftBarButtonItem.action=@selector(backToIndex);
 */

//self.navigationController.navigationBar.clipsToBounds = YES;

// [self.navigationController setNavigationBarHidden:YES];
// m_sqlite = [[CSqlite alloc]init];//SQL
// [m_sqlite openSqlite];

//    PPiFlatSegmentedControl *segmented2=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, 320, 35) items:
//    @[
//
//       @{@"text":@"地区"},
//       @{@"text":@"菜系"},
//       @{@"text":@"人气"}
//     ]
//    iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
//
//                                                                          }];
//    segmented2.color=[UIColor whiteColor];
//    segmented2.borderWidth=0.5;
//    segmented2.borderColor=[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
//    segmented2.selectedColor=[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
//    segmented2.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
//                                NSForegroundColorAttributeName:[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1]};
//    segmented2.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
//                                        NSForegroundColorAttributeName:[UIColor whiteColor]};
//    [self.view addSubview:segmented2];


