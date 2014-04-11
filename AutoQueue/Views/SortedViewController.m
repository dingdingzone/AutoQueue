//
//  SortedViewController.m
//  AutoQueue
//
//  Created by leo on 13-11-21.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "SortedViewController.h"
#import "UINavigationItem+custom.h"
#import "SortedService.h"
#import "SortedTableCell.h"
#import "User.h"
#import "SortedQueue.h"
#import "StringUtil.h"
#import "ProSetting.h"

@interface SortedViewController ()

@end

@implementation SortedViewController

@synthesize tableView;
@synthesize myDelegate;
SortedService *sortedService;
User *userObj;
NSMutableArray *dataArr;
SortedQueue *curSortedQueue;


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
    [ProSetting setNaviTitle:@"已排队列" :self];
	// Do any additional setup after loading the view.
    self.view.layer.backgroundColor = [ProSetting getColorByStr:@"f5f5f5"].CGColor;
    float srcHeight = [ProSetting getSysHeight:self.view];
    float chaVal = srcHeight - 480;
    tableView.frame = CGRectMake(tableView.frame.origin.x , tableView.frame.origin.y - chaVal , tableView.frame.size.width , tableView.frame.size.height + chaVal);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    sortedService = [SortedService alloc];
    myDelegate = [[UIApplication sharedApplication] delegate];
    dataArr = [[NSMutableArray alloc] init];
    userObj = myDelegate.userObj;
    [sortedService getSortedInfoList:[userObj userId] :dataArr];
//    NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
//    NSLog(@"%@" , visiblePaths);
}

-(void)backToIndex
{
    //do something.
    [self performSegueWithIdentifier:@"segue_numback" sender:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SortedTableCell";
    SortedTableCell *cell = (SortedTableCell *)[self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SortedTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    SortedQueue *sortedQueue = [dataArr objectAtIndex:indexPath.row];
    cell.sortedName.text = [sortedQueue merchantName];
    cell.sortedAddr.text = [sortedQueue addr];
    cell.sortedType.text = [sortedQueue queueName];
    cell.sortedState.text = [sortedQueue status];
    cell.sortedPos.text = [NSString stringWithFormat:@"%@",[sortedQueue queueSeq]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [StringUtil getImageView:[sortedQueue imageName] :cell.sortedImg];
    if([[sortedQueue status] isEqualToString:@"等待中"])
    {
        cell.sortedState.text = [NSString stringWithFormat:@"%@...",[sortedQueue status]];
        [cell.bookBtn addTarget:self action:@selector(cancelBook:) forControlEvents:UIControlEventTouchDown ];
    }
    else
    {
        cell.sortedState.text = [sortedQueue status];
        cell.bookBtn.userInteractionEnabled = NO;
        [cell.bookBtn setTitle:@"取消预订" forState:UIControlStateDisabled];
        [cell.bookBtn setTitle:[NSString stringWithUTF8String:"取消预订"] forState:UIControlStateNormal];
        [cell.bookBtn setTintColor:[UIColor grayColor]];
        [cell.bookBtn setBackgroundColor:[ProSetting getColorByStr:@"e8d2bd"]];
        cell.sortedState.textColor=[UIColor grayColor];
        cell.sortedPos.hidden = YES;
        cell.sortedPosLab.hidden = YES;
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void) cancelBook:(id)sender
{
    UIAlertView *uiAlertView = [[UIAlertView alloc] initWithTitle:@"取消预占" message:@"您确认要取消当前预占?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [uiAlertView show];
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath * hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    curSortedQueue = [dataArr objectAtIndex:hitIndex.row];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1)
    {
        NSString *result = [sortedService cancelBook:[curSortedQueue queueId] :[userObj userId] :[userObj mobileNbr]];
        if([result isEqualToString:@"true"])
        {
            [dataArr removeAllObjects];
            int flag = [sortedService getSortedInfoList:[userObj userId] :dataArr];
            if(flag == 0)
            {
                [self backToIndex];
            }
            else
            {
                [tableView reloadData];
            }
        }
        else
        {
            [StringUtil tipsInfo:@"取消预占" :@"取消预占失败"];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
