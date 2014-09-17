//
//  BaseViewController.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-7-5.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize appDelegate;
@synthesize runningRequest = _runningRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appDelegate=[[UIApplication sharedApplication] delegate];
    
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIImage * img = [UIImage imageNamed:@"main_top_logo.png"];
    img=[img scaleToSize:CGSizeMake(25.0f, 25.0f)];
    [backButton setBackgroundImage:[img stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToIndex) forControlEvents:UIControlEventTouchUpInside];
    
    //    [self.navigationItem setUIBarButtonItem:self.navigationItem : backButton];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem =backItem;
}

#pragma mark------------------管理视图控制器堆栈数组(删除顶端试图及倒数第二层视图)
-(void) removeNavigationViewController
{
    NSArray *currentControllers = self.navigationController.viewControllers;//获得视图控制器堆栈数组
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];//基于堆栈数组实例化新的数组
    
    [newControllers removeLastObject];//移除堆栈顶端数组
    
    [newControllers removeObjectAtIndex:[newControllers count]-1];//移除堆栈顶端数组
    //    self.navigationController.viewControllers = newControllers;//为堆栈重新赋值
    [self.navigationController setViewControllers:newControllers animated:YES];//为堆栈重新赋值
}

#pragma mark------------------设置导航条左边title
-(void) setNavigationLeftItemTitle:(NSString*)title:(int) viewTag
{
    for(UIView * myView in self.navigationController.navigationBar.subviews)
    {
        if(myView.tag==viewTag)
        {
            UILabel * label=myView;
            label.text=title;
        }
    }
}

-(void)backToIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)myTask
{
	// Do something usefull in here instead of sleeping ...
	sleep(100);
}

- (void)myProgressTask
{
	// This just increases the progress indicator in a loop
	float progress = 0.0f;
	while (progress < 1.0f)
    {
		progress += 0.01f;
		HUD.progress = progress;
		usleep(50000);
	}
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	
	HUD = nil;
}

-(void)showProgress
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
	
	// Show the HUD while the provided method executes in a new thread
	[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

-(void) freashTableView
{
    NSLog(@"tiankang");
}


@end
