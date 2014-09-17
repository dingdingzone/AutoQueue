//
//  HeadViewController.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-3-6.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "HeadViewController.h"
#import "QueueAppDelegate.h"
@interface HeadViewController ()

@end

@implementation HeadViewController
@synthesize delegate;
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
    // Do any additional setup after loading the view from its nib.
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)foodOnClick:(id)sender
{
//     UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    
//     UIViewController* test2obj = [stryBoard instantiateViewControllerWithIdentifier:@"LoginView"]; //test2为viewcontroller的
  //  [self presentModalViewController:test2obj animated:YES];
       //[self addChildViewController:test2obj];
 //  [self presentModalViewController:test2obj animated:YES];
//    [super performSegueWithIdentifier:@"tabSegue" sender:self];
    ////NSLog(@"%@",self.navigationController);
 //   [self.view setHidden:YES];
    //[navigationController pushViewController:test2obj animated:YES];
    //self.view.window.rootViewController=test2obj;
    
//    if([delegate respondsToSelector:@selector(textEntered:)])
//    {
//        //send the delegate function with the amount entered by the user
//        [delegate pushViewBySegue];
//    }
    QueueAppDelegate * delegate=[[UIApplication sharedApplication] delegate];
    [delegate.tabView performSegueWithIdentifier:@"tabSegue" sender:self];
}

-(void)queueOnClick:(id)sender
{
    QueueAppDelegate * delegate=[[UIApplication sharedApplication] delegate];
    [delegate.tabView performSegueWithIdentifier:@"queue_segue" sender:self];
}

-(IBAction)huntOnClick:(id)sender
{
    QueueAppDelegate * delegate=[[UIApplication sharedApplication] delegate];
    [delegate.tabView performSegueWithIdentifier:@"hunt_segue" sender:self];
}

@end
