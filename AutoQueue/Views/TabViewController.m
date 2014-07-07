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
#import "TopBarViewController.h"
@interface TabViewController ()

@end

UIViewController * topView ;

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
    delegate.topView=topView;
    
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
    UIColor *textColor=[[UIColor alloc]initWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1];

    UIImage* tabBarBackground = [UIImage imageNamed:@"main_menu_bg.jpg"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    /*背景图*/
//  [[UITabBar appearance] setSelectionIndicatorImage:[TabViewController createImageWithColor:selectedzColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       textColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    
   
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       colorSelect, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
    [self.view addSubview:tabBarViewController.view];
    

    [self addTopBarItems];
//     topView = [TopBarViewController alloc];
//     topView.view.tag=10000;
//     [self.navigationController.navigationBar addSubview: topView.view] ;
    
}

#pragma mark 添加导航条TOPBAR的ITEM
-(void) addTopBarItems
{
    UIButton * backBtn=[[UIButton alloc] initWithFrame:CGRectMake(6.0f, 15.0f, 5.0f, 14.0f)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"left_arrow_gray.png" ] forState:UIControlStateNormal];
    backBtn.tag=1;
    backBtn.hidden=YES;
    [self.navigationController.navigationBar addSubview: backBtn];
    
    
    UILabel* areaLabel;
    areaLabel=[[UILabel alloc] initWithFrame:CGRectMake(118.0f, 16.0f, 50.0f, 20.0f)];
    areaLabel.text=@"武汉";
    areaLabel.font=[UIFont systemFontOfSize:12];
    areaLabel.backgroundColor = [UIColor clearColor];
    areaLabel.tag=2;
    [self.navigationController.navigationBar addSubview: areaLabel];
    
    UILabel* logoLabel;
    logoLabel=[[UILabel alloc] initWithFrame:CGRectMake(42.0f, 16.0f, 70.0f, 20.0f)];
    logoLabel.text=@"添翼好吃佬";
    logoLabel.textColor=[UIColor redColor];
    logoLabel.font=[UIFont systemFontOfSize:14];
    logoLabel.backgroundColor = [UIColor clearColor];
    logoLabel.tag=3;
    [self.navigationController.navigationBar addSubview: logoLabel];
    
    UILabel* titleLabel;
    titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(42.0f, 16.0f, 70.0f, 20.0f)];
    titleLabel.text=@"自助排队";
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.tag=4;
    titleLabel.hidden=YES;
    [self.navigationController.navigationBar addSubview: titleLabel];
    
    UIButton * addressBtn=[[UIButton alloc] initWithFrame:CGRectMake(145.0f, 25.0f, 10.0f, 6.0f)];
    [addressBtn setBackgroundImage:[UIImage imageNamed:@"down_arrow.png" ] forState:UIControlStateNormal];
    addressBtn.tag=5;
    [self.navigationController.navigationBar addSubview: addressBtn];
    
    UIButton * searchBtn=[[UIButton alloc] initWithFrame:CGRectMake(235.0f, 10.0f, 25.0f,25.0f)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"main_top_search.png" ] forState:UIControlStateNormal];
    searchBtn.tag=6;
    [self.navigationController.navigationBar addSubview: searchBtn];
    
    UIButton * scanBtn=[[UIButton alloc] initWithFrame:CGRectMake(280.0f, 10.0f, 25.0f,25.0f)];
    [scanBtn setBackgroundImage:[UIImage imageNamed:@"erweima_img.png" ] forState:UIControlStateNormal];
    scanBtn.tag=7;
    [self.navigationController.navigationBar addSubview: scanBtn];
    
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
