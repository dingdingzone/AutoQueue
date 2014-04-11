//
//  MyQueueController.m
//  AutoQueue
//
//  Created by alone on 13-11-20.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "MyQueueController.h"
#import "UINavigationItem+custom.h"
#import "MyQueueService.h"
#import "User.h"
#import "StringUtil.h"

@interface MyQueueController ()

@end

@implementation MyQueueController

@synthesize myDelegate;
@synthesize queuePic;
@synthesize queueSeqLab;

MyQueueService *myQueueService;
User *userObj;
NSString *queueSeq;


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
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"我的页面背景.jpg"] ];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    myQueueService = [MyQueueService alloc];
    myDelegate = [[UIApplication sharedApplication] delegate];
    userObj = myDelegate.userObj;
    queueSeq = [myQueueService getQueuedCount:userObj.userId];
    if([queueSeq isEqualToString:@"0"])
    {
        queuePic.hidden = YES;
        queueSeqLab.hidden = YES;
    }
    else
    {
        queueSeqLab.text = queueSeq;
    }

}
-(void)backToIndex
{
    //do something.
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)unLogin:(id)sender
{
    UIAlertView *uiAlertView = [[UIAlertView alloc] initWithTitle:@"用户注销" message:@"您确认要注销当前登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [uiAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1)
    {
        myDelegate.userObj = nil;
        [self performSegueWithIdentifier:@"segue_merListInfo" sender:self];
    }
}

-(IBAction)selfQueueClick:(id)sender
{
    [self performSegueWithIdentifier:@"segue_merListInfo" sender:self];
}

-(IBAction)queuedClick:(id)sender
{
    if([queueSeq isEqualToString:@"0"])
    {
        [StringUtil tipsInfo:@"提示" :@"亲 您还没有进行排序咯!"];
    }
    else
    {
        [self performSegueWithIdentifier:@"segue_queued" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
