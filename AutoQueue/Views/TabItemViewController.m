//
//  TabItemViewController.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-3-31.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "TabItemViewController.h"
#import "ProSetting.h"
@interface TabItemViewController ()

@end

@implementation TabItemViewController
@synthesize  headViewController;
@synthesize myscrollview;
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
    float screenHight=[ProSetting getScreenHeight];
    myscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0,0.0,320,screenHight)];
    myscrollview.directionalLockEnabled = YES; //只能一个方向滑动
    myscrollview.pagingEnabled = NO; //是否翻页
    myscrollview.backgroundColor = [UIColor whiteColor];
    myscrollview.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
    myscrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    myscrollview.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    myscrollview.delegate = self;
    CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.bounds.size.height+480);
    [myscrollview setContentSize:newSize];
    
    headViewController=[HeadViewController alloc];
    favourViewController=[FavourViewController alloc];
    
    [myscrollview addSubview:headViewController.view];
    // NSLog(@"%f",self.view.bounds.size.height);
    [favourViewController.view setFrame:CGRectMake(0.0,headViewController.view.bounds.size.height,320.0,568.0)];
    [myscrollview addSubview:favourViewController.view];
    [self.view addSubview:myscrollview];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithViewController:(UIViewController*)viewController
{
    self = [super init];
    if(self)
    {
        
        float screenHight=[ProSetting getScreenHeight];
        myscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0,0.0,320,screenHight)];
        myscrollview.directionalLockEnabled = YES; //只能一个方向滑动
        myscrollview.pagingEnabled = NO; //是否翻页
        myscrollview.backgroundColor = [UIColor whiteColor];
        myscrollview.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
        myscrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
        myscrollview.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
        myscrollview.delegate = self;
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.bounds.size.height+480);
        [myscrollview setContentSize:newSize];
        
        headViewController=[HeadViewController alloc];
        favourViewController=[FavourViewController alloc];
        
        [myscrollview addSubview:headViewController.view];
        // NSLog(@"%f",self.view.bounds.size.height);
        [favourViewController.view setFrame:CGRectMake(0.0,headViewController.view.bounds.size.height,320.0,568.0)];
        [myscrollview addSubview:favourViewController.view];
        [self.view addSubview:myscrollview];
        
        
        
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
