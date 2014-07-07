//
//  QueueViewController.m
//  AutoQueue
//
//  Created by alone on 14-04-11.
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
int refreshNum;
int posNum;

@synthesize tableView;
@synthesize loginBtn;
@synthesize searchShop;
@synthesize searchSeg;
@synthesize myDelegate;
@synthesize topBarDelegate;

AKSegmentedControl * segmentedControl;

- (void)viewDidLoad
{
    searchShop.delegate = self;
    myDelegate = [[UIApplication sharedApplication] delegate];
    userObj = myDelegate.userObj;
    
    segmentedControl = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(-1.0,63.0,322.0, 35.0)];
   
    segmentedControl=[segmentedControl setupSegmentedControl:segmentedControl];
    // [segmentedControl setDelegate:self];
    
 
   // m_sqlite = [[CSqlite alloc]init];//SQL
   // [m_sqlite openSqlite];
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
    [super viewDidLoad];
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

#pragma mark------------------加载tableview数据
-(void)loadingTableData
{
    MerImageArr = [[NSMutableArray alloc] init];
    MerNameArr = [[NSMutableArray alloc] init];
    MerAddrArr = [[NSMutableArray alloc] init];
    MerCountArr = [[NSMutableArray alloc] init];
    MerIdArr = [[NSMutableArray alloc] init];
    
    float srcHeight = [ProSetting getSysHeight:self.view];
    float chaVal = srcHeight - 505;

    tableView.frame = CGRectMake(tableView.frame.origin.x , tableView.frame.origin.y - chaVal , tableView.frame.size.width , tableView.frame.size.height + chaVal);
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setTableFooterView:v];
    
    posNum = 1;
    NSString * param = [AutoQueueUtil getMerchantInfoParam:@"" :@"" :@"" :@"" :@"" :@"" :@"":[NSString stringWithFormat:@"%d",posNum] :@"10"];
    NetWebServiceRequest *request =[AutoQueueUtil  initServiceRequest:param];
    [request startAsynchronous];
    [request setDelegate:self];
    self.runningRequest = request;
}


- (void)netRequestStarted:(NetWebServiceRequest *)request
{
    [self shwoProgress];
    NSLog(@"Start");
}


- (void)netRequestFinished:(NetWebServiceRequest *)request finishedInfoToResult:(NSString *)result responseData:(NSData *)requestData
{
    NSLog(@"Result");
    NSString *resultMsg = [[NSString alloc] initWithData:requestData  encoding:NSUTF8StringEncoding];
    NSLog(@"%@",resultMsg);
    
    NSString *jsonStr = [SoapXmlParseHelper SoapMessageResultXml:resultMsg ServiceMethodName:@"ns:return"];
    NSString *returnMsgStr = [SBJsonObj getNodeStr:jsonStr :@"merchantList"];
    
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
    
    if (refreshHeaderView == nil)
    {
    
    	 EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    		view.delegate = self;
        [self.tableView addSubview:view];
        refreshHeaderView = view;
        [tableView reloadData];
    }
    
    [self hudWasHidden:HUD];//结束进度条
    
}

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

///////////////////

- (void)reloadTableViewDataSource{
	reloading = YES;
}

- (void)doneLoadingTableViewData{
	reloading = NO;
	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
	[self reloadTableViewDataSource];
    
    //停止加载，弹回下拉
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
    
    if (barView == nil) {
        UIImage *img = [[UIImage imageNamed:@"timeline_new_status_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        barView = [[UIImageView alloc] initWithImage:img];
        barView.frame = CGRectMake(0, 60, 320, 40);
        [self.view addSubview:barView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 100;
        label.font = [UIFont systemFontOfSize:16.0f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [barView addSubview:label];
    }
    UILabel *label = (UILabel *)[barView viewWithTag:100];
    if (refreshNum == 0)
    {
        label.text = @"木有更新咯";
    }
    else
    {
        label.text = [NSString stringWithFormat:@"%d条信息更新",refreshNum];
    }
    label.textColor = [ProSetting getColorByStr:@"52718b"];
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.origin = CGPointMake((barView.frame.size.width - frame.size.width)/2, (barView.frame.size.height - frame.size.height)/2);
    label.frame = frame;
    
    
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:0.6];
    
}

- (void)updateUI {
    [UIView animateWithDuration:0.6 animations:^{
        CGRect frame = barView.frame;
        frame.origin.y = 60;
        barView.frame = frame;
    } completion:^(BOOL finished){
        if (finished) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:1.0];
            [UIView setAnimationDuration:0.6];
            CGRect frame = barView.frame;
            frame.origin.y = -40;
            barView.frame = frame;
            [UIView commitAnimations];
        }
    }];
    if(refreshNum != 0)
    {
        posNum++;
    }
    int tempNum = [MerNameArr count];
    [queueService getMerchantInfo:@"" :@"" :@"" :@"" :@"" :@"" :@"" :MerImageArr :MerNameArr :MerAddrArr :MerCountArr :MerIdArr :[NSString stringWithFormat:@"%d",posNum] :@"10"];
    refreshNum = [MerNameArr count] - tempNum;
    
    [tableView reloadData];
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return reloading; // should return if data source model is reloading
	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

/////////////////////



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
