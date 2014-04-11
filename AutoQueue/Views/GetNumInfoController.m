//
//  GetNumInfoController.m
//  AutoQueue
//
//  Created by leo on 13-12-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "GetNumInfoController.h"
#import "UINavigationItem+custom.h"
#import "ProSetting.h"

@interface GetNumInfoController ()

@end

@implementation GetNumInfoController

@synthesize queueSeqTxt;
@synthesize queueCountTxt;
@synthesize merchantId;
@synthesize queueSeq;
@synthesize queueCount;
@synthesize queueId;

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
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [backButton addTarget:self action:@selector(backToIndex) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setUIBarButtonItem:self.navigationItem : backButton];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.layer.backgroundColor = [ProSetting getColorByStr:@"f5f5f5"].CGColor;
    queueSeqTxt.text = [NSString stringWithFormat:@"%@",queueSeq];
    queueCountTxt.text = [NSString stringWithFormat:@"%@",queueCount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToIndex
{
    //do something.
    [self.navigationController popViewControllerAnimated:YES];
}

@end
