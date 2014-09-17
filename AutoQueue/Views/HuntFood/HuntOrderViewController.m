//
//  HuntOrderViewController.m
//  AutoQueue
//
//  Created by leon on 14-9-17.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "HuntOrderViewController.h"
#import "ProSetting.h"

@interface HuntOrderViewController ()

@end

@implementation HuntOrderViewController

@synthesize orderSegmentedControl;
@synthesize orderScrollView;
@synthesize bookSegmentedControl;
@synthesize bookScrollView;

@synthesize ChoSeat;
@synthesize ChoDish;
@synthesize price;
@synthesize eatTime;

@synthesize orderDataList;
@synthesize orderTableView;
@synthesize bookDataList;
@synthesize bookTableView;

UIView *huntChoOrder;

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
    
    PPiFlatSegmentedControl *segmented=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(30, 75, 260, 30) items:@[@{@"text":@"订座"},@{@"text":@"点菜"}] iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
        NSLog(@"%d" , segmentIndex);
        switch(segmentIndex)
        {
            case 0:
                orderSegmentedControl.hidden = NO;
                orderScrollView.hidden = NO;
                bookSegmentedControl.hidden = YES;
                bookScrollView.hidden = YES;
                break;
            case 1:
                orderSegmentedControl.hidden = YES;
                orderScrollView.hidden = YES;
                bookSegmentedControl.hidden = NO;
                bookScrollView.hidden = NO;
                break;
        }
    }];
    segmented.color=[ProSetting getColorByStr:@"cccccc"];
    segmented.borderWidth=0.5;
    segmented.borderColor=[UIColor grayColor];
    segmented.selectedColor=[ProSetting getColorByStr:@"cc3333"];
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                        NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"];
    eatTime.text = [NSString stringWithFormat:@"就餐时间：%@",[dateFormatter stringFromDate:[NSDate date]]];
    [self bookSegment];
    [self orderSegment];
    bookSegmentedControl.hidden = YES;
    bookScrollView.hidden = YES;
    
    NSArray *choAreaArr = [[NSBundle mainBundle]loadNibNamed:@"huntOrderBottom" owner:self options:nil];
    if(choAreaArr.count > 0)
    {
        huntChoOrder = (UIView *)[choAreaArr objectAtIndex:0];
        float screenHeight = [ProSetting getScreenHeight];
        huntChoOrder.frame = CGRectMake(0, screenHeight - 65, 320, 65);
        [self.view insertSubview:huntChoOrder atIndex:5];
    }
}

-(void)orderSegment
{
    NSArray *titles = @[@"全部", @"凉菜", @"热菜"];
    self.orderSegmentedControl = [[SMVerticalSegmentedControl alloc] initWithSectionTitles:titles];
    self.orderSegmentedControl.backgroundColor = [ProSetting getColorByStr:@"ecf0f1"];
    self.orderSegmentedControl.selectionStyle = SMVerticalSegmentedControlSelectionStyleBox;
    self.orderSegmentedControl.selectionIndicatorThickness = 4;
    [self.orderSegmentedControl setFrame:CGRectMake(0, 140, 85, 150)];
    [self.view addSubview:self.orderSegmentedControl];
    
    CGFloat scrollWidth = CGRectGetWidth(self.view.bounds) - 85;
    CGFloat screenHeight = CGRectGetHeight(self.view.bounds) - 200;
    self.orderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(85,140,scrollWidth,screenHeight)];
    
    [self.orderScrollView setPagingEnabled:YES];
    [self.orderScrollView setShowsVerticalScrollIndicator:NO];
    [self.orderScrollView setContentSize:CGSizeMake(scrollWidth, [titles count] * screenHeight)];
    [self.orderScrollView scrollRectToVisible:CGRectMake(320, 0, 320, 100) animated:NO];
    self.orderScrollView.delegate = self;
    [self.view insertSubview:self.orderScrollView atIndex:2];
    
    // set default settings for semented controls in UIScrollView
    [SMVerticalSegmentedControl appearanceWhenContainedIn:[UIScrollView class], nil].backgroundColor = [ProSetting getColorByStr:@"3498db"];
    [SMVerticalSegmentedControl appearanceWhenContainedIn:[UIScrollView class], nil].textColor = [UIColor blackColor];
    [SMVerticalSegmentedControl appearanceWhenContainedIn:[UIScrollView class], nil].selectedTextColor = [ProSetting getColorByStr:@"34495e"];
    [SMVerticalSegmentedControl appearanceWhenContainedIn:[UIScrollView class], nil].selectionIndicatorColor = [ProSetting getColorByStr:@"34495e"];
    
    [titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, idx * screenHeight, scrollWidth, screenHeight)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self.orderScrollView addSubview:view];
        [self createExample:idx inView:view];
    }];
    
    __block HuntOrderViewController *_self = self;
    self.orderSegmentedControl.indexChangeBlock = ^(NSInteger index) {
        [_self.orderScrollView scrollRectToVisible:CGRectMake(0, index * screenHeight, scrollWidth, screenHeight) animated:YES];
    };
}

-(void)bookSegment
{
    NSArray *titles = @[@"全部", @"包厢", @"散台"];
    self.bookSegmentedControl = [[SMVerticalSegmentedControl alloc] initWithSectionTitles:titles];
    self.bookSegmentedControl.backgroundColor = [ProSetting getColorByStr:@"ecf0f1"];
    self.bookSegmentedControl.selectionStyle = SMVerticalSegmentedControlSelectionStyleBox;
    self.bookSegmentedControl.selectionIndicatorThickness = 4;
    [self.bookSegmentedControl setFrame:CGRectMake(0, 140, 85, 150)];
    [self.view addSubview:self.bookSegmentedControl];
    
    CGFloat scrollWidth = CGRectGetWidth(self.view.bounds) - 85;
    CGFloat screenHeight = CGRectGetHeight(self.view.bounds) - 200;
    self.bookScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(85,140,scrollWidth,screenHeight)];
    
    [self.bookScrollView setPagingEnabled:YES];
    [self.bookScrollView setShowsVerticalScrollIndicator:NO];
    [self.bookScrollView setContentSize:CGSizeMake(scrollWidth, [titles count] * screenHeight)];
    [self.bookScrollView scrollRectToVisible:CGRectMake(320, 0, 320, 100) animated:NO];
    self.bookScrollView.delegate = self;
    [self.view insertSubview:self.bookScrollView atIndex:2];
    
    // set default settings for semented controls in UIScrollView
    [SMVerticalSegmentedControl appearanceWhenContainedIn:[UIScrollView class], nil].backgroundColor = [ProSetting getColorByStr:@"3498db"];
    [SMVerticalSegmentedControl appearanceWhenContainedIn:[UIScrollView class], nil].textColor = [UIColor blackColor];
    [SMVerticalSegmentedControl appearanceWhenContainedIn:[UIScrollView class], nil].selectedTextColor = [ProSetting getColorByStr:@"34495e"];
    [SMVerticalSegmentedControl appearanceWhenContainedIn:[UIScrollView class], nil].selectionIndicatorColor = [ProSetting getColorByStr:@"34495e"];
    
    [titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, idx * screenHeight, scrollWidth, screenHeight)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self.bookScrollView addSubview:view];
        [self createExample:idx inView:view];
    }];
    
    __block HuntOrderViewController *_self = self;
    self.bookSegmentedControl.indexChangeBlock = ^(NSInteger index) {
        [_self.bookScrollView scrollRectToVisible:CGRectMake(0, index * screenHeight, scrollWidth, screenHeight) animated:YES];
    };
}

- (void)createExample:(NSUInteger)exampleNumber inView:(UIView *)view
{

    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageHeight = CGRectGetHeight(scrollView.frame);
    NSInteger page = scrollView.contentOffset.y / pageHeight;
    
    if(scrollView == bookScrollView)
    {
        [self.bookSegmentedControl setSelectedSegmentIndex:page animated:YES];
    }
    else
    {
        [self.orderSegmentedControl setSelectedSegmentIndex:page animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == orderTableView)
    {
        return [orderDataList count];
    }
    else
    {
        return [bookDataList count];
    }
}

#pragma mark-----------------初始化TableView cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == orderTableView)
    {
//        static NSString *queueTableIdentifier = @"huntCell";
//        HuntFoodCellViewController *cell = (HuntFoodCellViewController *)[self.tableView dequeueReusableCellWithIdentifier:queueTableIdentifier];
//        if (cell == nil)
//        {
//            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"huntCell" owner:self options:nil];
//            cell = [nib objectAtIndex:0];
//        }
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//        cell.MerName.text = [MerNameArr objectAtIndex:indexPath.row];
//        NSString *url = [MerImageArr objectAtIndex:indexPath.row];
//        if(![url isEqualToString:@""])
//        {
//            [StringUtil getImageView:[MerImageArr objectAtIndex:indexPath.row] :cell.MerImage];
//        }
//        else
//        {
//            UIImage *image = [UIImage imageNamed:@"default_loading_img.png"];
//            cell.MerImage.image = image;
//        }
//        cell.MerAddr.text = [MerAddrArr objectAtIndex:indexPath.row];
//        return cell;
    }
    else
    {
//        static NSString *queueTableIdentifier = @"huntCell";
//        HuntFoodCellViewController *cell = (HuntFoodCellViewController *)[self.tableView dequeueReusableCellWithIdentifier:queueTableIdentifier];
//        if (cell == nil)
//        {
//            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"huntCell" owner:self options:nil];
//            cell = [nib objectAtIndex:0];
//        }
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//        cell.MerName.text = [MerNameArr objectAtIndex:indexPath.row];
//        NSString *url = [MerImageArr objectAtIndex:indexPath.row];
//        if(![url isEqualToString:@""])
//        {
//            [StringUtil getImageView:[MerImageArr objectAtIndex:indexPath.row] :cell.MerImage];
//        }
//        else
//        {
//            UIImage *image = [UIImage imageNamed:@"default_loading_img.png"];
//            cell.MerImage.image = image;
//        }
//        cell.MerAddr.text = [MerAddrArr objectAtIndex:indexPath.row];
//        return cell;
    }
    return nil;
}

-(IBAction)enterClick:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
