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
    
    
//    UIToolbar * mycustomToolBar;
//    mycustomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(80.0f, 5.0f,1.0f, 40.0f)];
   // mycustomToolBar.center = CGPointMake(160.0f,200.0f);
  //  mycustomToolBar.barStyle = UIBarStyleDefault;
//    NSMutableArray *mycustomButtons = [[NSMutableArray alloc] init];
//    UIBarButtonItem *myButton1 = [[UIBarButtonItem alloc]
//                                  initWithTitle:@"Get5"
//                                  style:UIBarButtonItemStyleBordered
//                                  target:self
//                                  action:@selector(action)];
//    myButton1.width = 40;
//    [mycustomButtons addObject: myButton1];
//    UIBarButtonItem *myButton2 = [[UIBarButtonItem alloc]
//                                  initWithTitle:@"Play5"
//                                  style:UIBarButtonItemStyleBordered
//                                  target:self
//                                  action:@selector(action)];
//    myButton2.width = 40;
//    [mycustomButtons addObject: myButton2];
//    [mycustomToolBar setItems:mycustomButtons animated:YES];
//    mycustomToolBar.barStyle = UIBarStyleDefault;
//    [mycustomToolBar setItems:mycustomButtons animated:YES];
    //[mycustomToolBar sizeToFit];
 //  [self.navigationController.navigationBar addSubview: mycustomToolBar];
    //[self.view addSubview:mycustomToolBar];
//    self.navigationItem.titleView = mycustomToolBar;

//    [self.navigationController setNavigationBarHidden:YES];
//    self.navigationController.navigationBar.alpha = 0.3;
   
    UILabel* myLabel;
    myLabel=[[UILabel alloc] initWithFrame:CGRectMake(118.0f, 16.0f, 50.0f, 20.0f)];
    myLabel.text=@"武汉";
    myLabel.font=[UIFont systemFontOfSize:12];
    myLabel.backgroundColor = [UIColor clearColor];
//    [self.navigationController.navigationBar addSubview: myLabel];
    
    UILabel* logoLabel;
    logoLabel=[[UILabel alloc] initWithFrame:CGRectMake(42.0f, 16.0f, 70.0f, 20.0f)];
    logoLabel.text=@"添翼好吃佬";
    logoLabel.textColor=[UIColor redColor];
    logoLabel.font=[UIFont systemFontOfSize:14];
    logoLabel.backgroundColor = [UIColor clearColor];
//    [self.navigationController.navigationBar addSubview: logoLabel];
    

    UIButton * addressBtn=[[UIButton alloc] initWithFrame:CGRectMake(145.0f, 25.0f, 10.0f, 6.0f)];
    [addressBtn setBackgroundImage:[UIImage imageNamed:@"down_arrow.png" ] forState:UIControlStateNormal];
//    [self.navigationController.navigationBar addSubview: addressBtn];
    
    UIButton * searchBtn=[[UIButton alloc] initWithFrame:CGRectMake(235.0f, 10.0f, 25.0f,25.0f)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"main_top_search.png" ] forState:UIControlStateNormal];
//    [self.navigationController.navigationBar addSubview: searchBtn];
    
     topView = [TopBarViewController alloc];
     topView.view.tag=10000;
     [self.navigationController.navigationBar addSubview: topView.view];
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
