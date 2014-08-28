//
//  TopBarViewController.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-7-1.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "TopBarViewController.h"

@interface TopBarViewController ()

@end

@implementation TopBarViewController

@synthesize logoImg;
@synthesize topBackBtn;
@synthesize topTitleLabel;
@synthesize searchBtn;
@synthesize areaImg;
@synthesize areaLabel;
@synthesize scanBtn;

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
    // Do any additional setup after loading the view from its nib.
    topBackBtn.hidden=YES;
    [self.view setFrame:CGRectMake(0, 0, 320, 40)];
    self.view.backgroundColor=[UIColor clearColor];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hiddenTopBar
{
   // [self.view setFrame:CGRectMake(0,0, 60, 14)];
    topBackBtn.hidden=NO;
    [logoImg removeFromSuperview];
    [areaLabel removeFromSuperview];
    [areaImg removeFromSuperview];
    [topTitleLabel removeFromSuperview];
    [searchBtn removeFromSuperview];
    [scanBtn removeFromSuperview];
}


@end
