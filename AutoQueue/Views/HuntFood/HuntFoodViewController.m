//
//  HuntFoodViewController.m
//  AutoQueue
//
//  Created by leon on 14-9-11.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "HuntFoodViewController.h"
#import "HuntFoodCellViewController.h"
#import "SoapXmlParseHelper.h"
#import "DoubleTableController.h"
#import "FPPopoverController.h"
#import "AKSegmentedControl.h"
#import "QueueService.h"
#import "StringUtil.h"
#import "User.h"
#import "ProSetting.h"
#import "HuntFoodDetailViewController.h"

#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"

@interface HuntFoodViewController ()

@end

@implementation HuntFoodViewController

@synthesize myDelegate;
@synthesize tableView;


AKSegmentedControl * segmentedControl;

QueueService *queueService;

NSMutableArray *MerImageArr;
NSMutableArray *MerNameArr;
NSMutableArray *MerAddrArr;
NSMutableArray *MerCountArr;
NSMutableArray *MerIdArr;
User *userObj;

/*分页页数*/
int posNum;

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
    
    posNum =1;
    
    // 1.注册cell
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    //tableView.dataSource = self;
    //tableView.delegate = self;
    
    
    // 2.集成刷新控件
    [self setupRefresh];
    
    MerImageArr = [[NSMutableArray alloc] init];
    MerNameArr = [[NSMutableArray alloc] init];
    MerAddrArr = [[NSMutableArray alloc] init];
    MerCountArr = [[NSMutableArray alloc] init];
    
    MerIdArr = [[NSMutableArray alloc] init];
    
    myDelegate = [[UIApplication sharedApplication] delegate];
    userObj = myDelegate.userObj;
    
    segmentedControl = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(-1.0,-1.0,322.0, 35.0)];
    
    segmentedControl=[segmentedControl setupSegmentedControl:segmentedControl];
    
    // [segmentedControl setDelegate:self];
    
    segmentedControl.baseViewController=self;
    [self.view addSubview:segmentedControl];
    
    self.view.layer.backgroundColor = [UIColor grayColor].CGColor;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        
    }
    
	// Do any additional setup after loading the view, typically from a nib.
    self.view.layer.backgroundColor = [ProSetting getColorByStr:@"f5f5f5"].CGColor;
    
    //[self locationPosition];GPS
    [self loadingTableData];
    
    [self controlTopBarDisplay:NO];
    
}

-(void)reloadTableViewDataSource
{
    
}

-(void)doneLoadingTableViewData
{
    
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
    int h = STATUS_NAVI_H;
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
        if(myView.tag==1 || myView.tag==4)
        {
            myView.hidden=flag;
            if(myView.tag==4)
            {
                UILabel *labText = (UILabel *)myView;
                labText.text = @"美食发现";
            }
        }
        else if(myView.tag==2 || myView.tag==3 || myView.tag==4 || myView.tag==5 || myView.tag==6 || myView.tag==7)
        {
            myView.hidden=!flag;
        }
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
    static NSString *queueTableIdentifier = @"huntCell";
    HuntFoodCellViewController *cell = (HuntFoodCellViewController *)[self.tableView dequeueReusableCellWithIdentifier:queueTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"huntCell" owner:self options:nil];
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
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"hunt_detail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HuntFoodDetailViewController * detailViewController = segue.destinationViewController;
        detailViewController.MerId = [MerIdArr objectAtIndex:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
