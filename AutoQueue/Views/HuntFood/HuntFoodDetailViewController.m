//
//  HuntFoodDetailViewController.m
//  AutoQueue
//
//  Created by leon on 14-9-15.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "HuntFoodDetailViewController.h"

@interface HuntFoodDetailViewController ()

@end

@implementation HuntFoodDetailViewController

@synthesize scrollView;
@synthesize merId;

UIView *huntQueue;

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
    
    //设置UIScrollView
    scrollView.directionalLockEnabled = YES; //只能一个方向滑动
    scrollView.pagingEnabled = NO; //是否翻页
    scrollView.backgroundColor = [ProSetting getColorByStr:@"fef2e6"];
    scrollView.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    scrollView.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    /*获取ScrollView高度*/
    float scrollHeigth=[ProSetting getScrollViewHeight:self.scrollView];
    
    CGSize newSize = CGSizeMake(self.view.frame.size.width, scrollHeigth);
    [scrollView setContentSize:newSize];
    
}

-(IBAction)queueClick:(id)sender
{
    NSArray *nibViews = [[NSBundle mainBundle]loadNibNamed:@"HuntQueue" owner:self options:nil];
    if(nibViews.count > 0)
    {
        huntQueue = (UIView *)[nibViews objectAtIndex:0];
        huntQueue.frame = CGRectMake(0,200,huntQueue.frame.size.width,huntQueue.frame.size.height);
//        UIImage *maskImage = [UIImage imageNamed:@"bak.png"];
//        CALayer *masklayer = [[CALayer layer] init];
//        masklayer.frame = huntQueue.frame;
//        masklayer.contents = (id)[maskImage CGImage];
//        [[self.view layer] setMask:masklayer];
        [self.view addSubview:huntQueue];
    }
    else
    {
        NSLog(@"load nib error!");
    }
}

-(IBAction)queueEnterClick:(id)sender
{
    if(huntQueue != nil)
    {
        [huntQueue removeFromSuperview];
    }
}

-(IBAction)queueCancelClick:(id)sender
{
    if(huntQueue != nil)
    {
        [huntQueue removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
