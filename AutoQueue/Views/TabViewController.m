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
    
    tabBarViewController = [[UITabBarController alloc]init];
 //    tabBarViewController.tabBar.frame = CGRectMake(0, 430, 320, 60);
//    NSLog(@"%@",[self.view subviews]);
//    UIView * transitionView = [[tabBarViewController.view subviews] objectAtIndex:0];
//     Frame * anme =transitionView.frame;
//    ame.height=420;
//    transitionView.height = 460-40;
    QueueAppDelegate * delegate=[[UIApplication sharedApplication] delegate];
    delegate.tabView=self;
    
    TabItemViewController * tabItemView=[[TabItemViewController alloc] init];
    UITableViewController* second = [[UITableViewController alloc]init];
    UITableViewController* three = [[UITableViewController alloc]init];
    tabBarViewController.viewControllers = [NSArray arrayWithObjects:tabItemView, second,three, nil];
    
    
    UITabBar *tabBar = tabBarViewController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];

    
    tabBarItem1.title = @"首页";
    tabBarItem2.title = @"好吃佬";
    tabBarItem3.title = @"我的信息";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"tab_red_home.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_gray_home.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"tab_red_haochilao.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_gray_haochilao.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"tab_red_info.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_gray_info.png"]];

    
    
    UIColor *colorSelect=[[UIColor alloc]initWithRed:205/255.0 green:78/255.0 blue:97/255.0 alpha:1];
    UIColor *selectedzColor=[[UIColor alloc]initWithRed:205/255.0 green:78/255.0 blue:97/255.0 alpha:0];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"main_menu_bg.jpg"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    UIColor *textColor=[[UIColor alloc]initWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1];
    
//    [[UITabBar appearance] setSelectionIndicatorImage:[TabViewController createImageWithColor:selectedzColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       textColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    
   
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       colorSelect, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
    [self.view addSubview:tabBarViewController.view];
    
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(1.0f, 1.0f, 20.0f, 20.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
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
