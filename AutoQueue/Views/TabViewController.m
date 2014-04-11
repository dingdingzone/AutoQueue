//
//  TabViewController.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-3-27.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "TabViewController.h"
#import "TabItemViewController.h"
#import "QueueAppDelegate.h"

@interface TabViewController ()

@end

@implementation TabViewController

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
    
    tabBarViewController = [[UITabBarController alloc]init];
    QueueAppDelegate * delegate=[[UIApplication sharedApplication] delegate];
    delegate.tabView=self;

   // HeadViewController * headViewController= [[HeadViewController alloc] initWithNibName:@"HeadViewController" bundle:nil];
    
    
   // TabItemViewController * tabItemView=[[TabItemViewController alloc] initWithViewController:tabBarViewController];
    
    TabItemViewController * tabItemView=[[TabItemViewController alloc] init];

    
    UITableViewController* second = [[UITableViewController alloc]init];
    UITableViewController* three = [[UITableViewController alloc]init];
    UITableViewController* four = [[UITableViewController alloc]init];
    tabBarViewController.viewControllers = [NSArray arrayWithObjects:tabItemView, second,three,four, nil];
    
    
    UITabBar *tabBar = tabBarViewController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    tabBarItem1.title = @"首页";
    tabBarItem2.title = @"外卖订餐";
    tabBarItem3.title = @"好吃佬";
    tabBarItem4.title = @"我的信息";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"tab_red_home.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_white_home.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"tab_red_sale.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_white_sale.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"tab_red_haochilao.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_white_haochilao.png"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"tab_red_info.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_white_info.png"]];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    //    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected.png"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    
    UIColor *colorSelect=[[UIColor alloc]initWithRed:205/255.0 green:78/255.0 blue:97/255.0 alpha:1];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       colorSelect, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
    [self.view addSubview:tabBarViewController.view];
    
}

-(void)pushViewBySegue
{
    [self performSegueWithIdentifier:@"tabSegue" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
