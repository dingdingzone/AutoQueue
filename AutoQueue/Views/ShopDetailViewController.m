//
//  ShopDetailViewController.m
//  AutoQueue
//
//  Created by alone on 13-11-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "UINavigationItem+custom.h"
#import "ShopDetailService.h"
#import "SelPickerView.h"
#import "StringUtil.h"
#import "GetNumInfoController.h"
#import "Queue.h"
#import "User.h"
#import "SBJsonObj.h"
#import "ProSetting.h"
#import "SortedSelViewController.h"
#import "LoginViewController.h"

@interface ShopDetailViewController ()

@end

@implementation ShopDetailViewController

@synthesize MerName;
@synthesize MerAveConsume;
@synthesize MerType;
@synthesize MerCount;
@synthesize MerAddr;
@synthesize MerPhone;
@synthesize MerDiscount;
@synthesize MerDisc;
@synthesize MerTime;
@synthesize MerId;
@synthesize MerPicImage;
@synthesize myDelegate;
@synthesize scrollViewArea;

ShopDetailService *shopDetailService;
NSMutableArray *dataArr;
NSMutableArray *dataSelNumArr;
int selIndex;
User *userObj;
Queue *queueObj;
NSArray *picArr;
NSMutableArray *merImageArr;
UIView *maskView;
UIAlertView *noLoginAlertView;
UIAlertView *calledAlertView;
SortedSelViewController *sortedSelViewController;

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
	// Do any additional setup after loading the view.
    self.view.layer.backgroundColor = [ProSetting getColorByStr:@"f5f5f5"].CGColor;
    
    [self setNavigationLeftItemTitle:@"123":4];
    
    scrollViewArea.directionalLockEnabled = YES; //只能一个方向滑动
    scrollViewArea.pagingEnabled = NO; //是否翻页
    scrollViewArea.backgroundColor = [UIColor whiteColor];
    scrollViewArea.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
    scrollViewArea.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    scrollViewArea.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示

    /*获取ScrollView高度*/
    float scrollHeigth=[ProSetting getScrollViewHeight:self.scrollViewArea];
    
    CGSize newSize = CGSizeMake(self.view.frame.size.width, scrollHeigth);
    [scrollViewArea setContentSize:newSize];

    myDelegate = [[UIApplication sharedApplication] delegate];
    userObj = myDelegate.userObj;
    queueObj = [Queue alloc];
    
    dataSelNumArr = [[NSMutableArray alloc] init];
    merImageArr = [[NSMutableArray alloc] init];
    dataArr = [[NSMutableArray alloc] init];
    [self initDataLoad];
    MerPicImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [MerPicImage addGestureRecognizer:singleTap];
    
//    CGRect rect = {{20,40},{250,340}};
//    slideImageView = [[SlideImageView alloc]initWithFrame:rect ZMarginValue:5 XMarginValue:10 AngleValue:0.3 Alpha:1000];
//    slideImageView.borderColor = [UIColor whiteColor];
//    slideImageView.delegate = self;
    remBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 300, 40)];
    [remBtn setTitle:@"" forState:UIControlStateNormal];
    [remBtn addTarget:self action:@selector(exitImageView:) forControlEvents:UIControlEventTouchDown];
    

//    picArr = [dataArr objectAtIndex:9];
//    if([picArr count] != 0)
//    {
//        NSString *str = [[picArr objectAtIndex:0] objectForKey:@"imageName"];
////        [StringUtil getImageView:str :MerPicImage];
//    }
//    else
//    {
//        UIImage *image = [UIImage imageNamed:@"default_loading_img.png"];
//        MerPicImage.image = image;
//    }
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadMerImage) object:nil];
//    [thread start];
}

#pragma mark------------------------初始数据
-(void) initDataLoad
{
     NSString * param = [AutoQueueUtil getMerchantById:MerId];
    
    /*获取服务实例*/
    NetWebServiceRequest *request =[AutoQueueUtil  initServiceRequest:param];
    
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
   [self showProgress];
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
    BOOL MER_BASE_INFO_BOOL = MER_BASE_INFO(serviceCode);
    
    if (MER_BASE_INFO_BOOL)
    {
        NSMutableDictionary *dict = [SBJsonObj fromDitionary:returnMsg];
        [dataArr addObject:[dict objectForKey:@"merchantName"]];
        [dataArr addObject:[dict objectForKey:@"averageConsume"]];
        [dataArr addObject:[dict objectForKey:@"merchantType"]];
        [dataArr addObject:[dict objectForKey:@"queueCount"]];
        [dataArr addObject:[dict objectForKey:@"addr"]];
        [dataArr addObject:[dict objectForKey:@"contactNbr"]];
        [dataArr addObject:[dict objectForKey:@"discount"]];
        [dataArr addObject:[dict objectForKey:@"merchantDesc"]];
        [dataArr addObject:[dict objectForKey:@"openTime"]];
        [dataArr addObject:[dict objectForKey:@"imageInfo"]];
        
        NSString *merName = [dataArr objectAtIndex:0];
        MerName.text = merName;
        [ProSetting setNaviTitle:merName :self];
        [[dataArr objectAtIndex:1] isEqualToString:@""];
        MerAveConsume.text = [NSString stringWithFormat:@"￥%@",![[dataArr objectAtIndex:1] isEqualToString:@""]?[dataArr objectAtIndex:0]:@"0"];
        MerType.text = [dataArr objectAtIndex:2];
        MerCount.text = [NSString stringWithFormat:@"%@",[dataArr objectAtIndex:3]];
        MerAddr.text = [dataArr objectAtIndex:4];
        MerPhone.text = [dataArr objectAtIndex:5];
        MerDiscount.text = [dataArr objectAtIndex:6];
        MerDisc.text = [dataArr objectAtIndex:7];
        MerTime.text = [dataArr objectAtIndex:8];
    }
    [self hudWasHidden:HUD];//结束进度条
}


#pragma mark ------------------------------结束调用webservice服务组件
/*异步请求数据失败tableview*/
- (void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error
{
    NSLog(@"%@",error);
}




-(void)loadMerImage
{
    if(picArr != nil && [picArr count] != 0)
    {
        [merImageArr removeAllObjects];
        for(int i = 0 ;i < [picArr count];i++)
        {
            NSString *url = [[picArr objectAtIndex:i] objectForKey:@"imageName"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            if(data != nil)
            {
                [merImageArr addObject:data];
            }
        }
    }
}

-(void)onClickImage
{
    if(merImageArr != nil && [merImageArr count] != 0)
    {
        [self.view addSubview:slideImageView];
        [self.view addSubview:remBtn];
        [[slideImageView _imageArray] removeAllObjects];
        for(int i = 0,n = [merImageArr count];i < n;i++)
        {
            NSData *data = [merImageArr objectAtIndex:i];
            UIImage *image = [UIImage imageWithData:data];
            [slideImageView addImage:image];
        }
        [slideImageView setImageShadowsWtihDirectionX:2 Y:2 Alpha:0.7];
        [slideImageView reLoadUIview];
    }
}

- (void)exitImageView:(id)sender
{
    [slideImageView removeFromSuperview];
}

- (IBAction)getNumClick:(id)sender
{
    if(userObj != nil)
    {
        if([dataSelNumArr count] == 0)
        {
            [shopDetailService getQueueInfo:MerId :dataSelNumArr];
        }
        NSMutableArray *dataArr = [[NSMutableArray alloc] init];
        for(int i=0,n=[dataSelNumArr count];i < n;i++)
        {
            Queue *queue = [dataSelNumArr objectAtIndex:i];
            [dataArr addObject:[NSString stringWithFormat:@"%@(%@)",queue.queueName,queue.queueCount]];
        }
        if([dataArr count] != 0)
        {
            maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 360)];
            maskView.alpha = 0.6;
            maskView.backgroundColor = [UIColor grayColor];
            [self.view addSubview:maskView];
            [StringUtil showPickView:@"请选择要取的号码种类" :dataArr delegate:self];
        }
        else
        {
            [StringUtil tipsInfo:@"提示" :@"该商家没有排队序列"];
        }
    }
    else
    {
//        noLoginAlertView= [[UIAlertView alloc] initWithTitle:@"取号失败" message:@"您还未进行登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [noLoginAlertView show];
        LoginViewController * loginView=[LoginViewController alloc];
        [loginView setDelegate:self];
        [self.navigationController pushViewController:loginView animated:YES];

    }
    
//    NSArray *viewArr = [[NSBundle mainBundle]loadNibNamed:@"SortedSelController" owner:self options:nil];
//    sortedSelViewController = [viewArr objectAtIndex:0];
//    sortedSelViewController.view.frame = CGRectMake(0.0f, 190.0f, 320.0f, 197.0f);
//    sortedSelViewController.view.backgroundColor = [ProSetting getColorByStr:@"f5f5f5"];
//    [self.view addSubview:sortedSelViewController.view];
}

-(void) loginCallBack:(NSString *) result
{
    NSLog(@"------------@%",result);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == calledAlertView)
    {
        [self performSegueWithIdentifier:@"segue_called" sender:self];
    }
    else if(alertView == noLoginAlertView)
    {
        LoginViewController * loginView=[LoginViewController alloc];
        [self.navigationController pushViewController:loginView animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //You can uses location to your application.
    [maskView removeFromSuperview];
    if(buttonIndex == 1) {
        SelPickerView *selView = (SelPickerView *)actionSheet;
        selIndex = selView.selIndex;
        NSString *result = [shopDetailService getQueueNum:[[dataSelNumArr objectAtIndex:selIndex] queueId] :MerId :@"" :[userObj mobileNbr]];
        if([result isEqualToString:@"false"])
        {
            [StringUtil tipsInfo:@"取号失败" :@"未能成功取到号码"];
        }
        else if([result isEqualToString:@"123"])
        {
            calledAlertView= [[UIAlertView alloc] initWithTitle:@"取号失败" message:@"您在该商家中已排队" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [calledAlertView show];
        }
        else
        {
            NSDictionary *dict = [SBJsonObj fromDitionary:result];
            queueObj.queueSeq = [dict objectForKey:@"queueSeq"];
            queueObj.queueCount = [dict objectForKey:@"queueCount"];
            if([StringUtil isNullString:queueObj.queueSeq,queueObj.queueCount,nil])
            {
                [self performSegueWithIdentifier:@"Segue_getNumSucc" sender:self];
            }
            else
            {
                [StringUtil tipsInfo:@"取号失败" :@"未能成功取到号码"];
            }
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Segue_getNumSucc"])
    {
        GetNumInfoController *getNumInfoController = segue.destinationViewController;
        getNumInfoController.queueId = [[dataSelNumArr objectAtIndex:selIndex] queueId];
        getNumInfoController.merchantId = MerId;
        getNumInfoController.queueSeq = queueObj.queueSeq;
        getNumInfoController.queueCount = queueObj.queueCount;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)SlideImageViewDidClickWithIndex:(int)index
{
//    NSString* indexStr = [[NSString alloc]initWithFormat:@"点击了第%d张",index];
//    clickLabel.text = indexStr;
}

- (void)SlideImageViewDidEndScorllWithIndex:(int)index
{
//    NSString* indexStr = [[NSString alloc]initWithFormat:@"当前为第%d张",index];
//    indexLabel.text = indexStr;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


//    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    UIImage * img = [UIImage imageNamed:@"main_top_logo.png"];
//    img=[img scaleToSize:CGSizeMake(25.0f, 25.0f)];
//    [backButton setBackgroundImage:[img stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backToIndex) forControlEvents:UIControlEventTouchUpInside];
//
////    [self.navigationItem setUIBarButtonItem:self.navigationItem : backButton];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem =backItem;


