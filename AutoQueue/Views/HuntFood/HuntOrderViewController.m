//
//  HuntOrderViewController.m
//  AutoQueue
//
//  Created by leon on 14-9-17.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "HuntOrderViewController.h"
#import "ProSetting.h"
#import "HuntOrderCell.h"
#import "HuntBookCell.h"

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
@synthesize orderDataBoxList;
@synthesize boxTableView;
@synthesize orderDataCasualList;
@synthesize casualTableView;
@synthesize bookDataList;
@synthesize bookTableView;
@synthesize coldDataList;
@synthesize coldTableView;
@synthesize hotDataList;
@synthesize hotTableView;

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
        [self createExampleOrder:idx inView:view];
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
        [self createExampleBook:idx inView:view];
    }];
    
    __block HuntOrderViewController *_self = self;
    self.bookSegmentedControl.indexChangeBlock = ^(NSInteger index) {
        [_self.bookScrollView scrollRectToVisible:CGRectMake(0, index * screenHeight, scrollWidth, screenHeight) animated:YES];
    };
}

- (void)createExampleOrder:(NSUInteger)exampleNumber inView:(UIView *)view
{
    
}

- (void)createExampleBook:(NSUInteger)exampleNumber inView:(UIView *)view
{
//    NSArray *titles = @[@"item 1", @"item 2", @"item 3", @"item 4", @"item 5"];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 20, CGRectGetWidth(view.frame) - 4, 80)];
//    label.font = [UIFont systemFontOfSize:10];
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor clearColor];
//    label.numberOfLines = 0;
//    [view addSubview:label];
//    
//    SMVerticalSegmentedControl *segmentedControl = [[SMVerticalSegmentedControl alloc] initWithSectionTitles:titles];
//    
//    CGFloat segmentedControlHeight = 250;
//    CGFloat segmentedControlWidth  = 100;
//    
//    switch(exampleNumber) {
//        case 0:
//            label.text = @"Left aligned text\nLeft aligned selection indicator\nSelection indicator height is equal to text height";
//            break;
//        case 1:
//            label.text = @"Right aligned text\nRight aligned selection indicator\nSelection indicator height is equal to text height";
//            segmentedControl.textAlignment = SMVerticalSegmentedControlTextAlignmentRight;
//            segmentedControl.selectionLocation = SMVerticalSegmentedControlSelectionLocationRight;
//            break;
//        case 2:
//            label.text = @"Center aligned text\nSelection indictator style is equal to cell height";
//            segmentedControl.selectionStyle = SMVerticalSegmentedControlSelectionStyleFullHeightStrip;
//            segmentedControl.textAlignment = SMVerticalSegmentedControlTextAlignmentCenter;
//            break;
//        case 3:
//            label.text = @"Center aligned text\nBox selection style\nSelection indicator thickness is equal to zero\nBox border is equal to zero";
//            segmentedControl.textAlignment = SMVerticalSegmentedControlTextAlignmentCenter;
//            segmentedControl.selectionStyle = SMVerticalSegmentedControlSelectionStyleBox;
//            segmentedControl.selectionIndicatorThickness = 0;
//            segmentedControl.selectionBoxBorderWidth = 0;
//            break;
//        case 4:
//            label.text = @"Center aligned text\nBox selection style\nSelection indicator thickness is equal to zero\nBox border is equal to 2\nBox background color alpha is equal to 0.5\nBox border color alpha is equal to 0.7";
//            segmentedControl.textAlignment = SMVerticalSegmentedControlTextAlignmentCenter;
//            segmentedControl.selectionStyle = SMVerticalSegmentedControlSelectionStyleBox;
//            segmentedControl.selectionIndicatorThickness = 0;
//            segmentedControl.selectionBoxBorderWidth = 2;
//            segmentedControl.selectionBoxBackgroundColorAlpha = 0.5;
//            segmentedControl.selectionBoxBorderColorAlpha = 0.7;
//            
//            break;
//        default:
//            break;
//    }
//    
//    segmentedControl.frame = CGRectMake(CGRectGetWidth(view.frame) / 2 - segmentedControlWidth / 2,
//                                        CGRectGetHeight(view.frame) / 2 - segmentedControlHeight / 2,
//                                        segmentedControlWidth,
//                                        segmentedControlHeight);
//    [view addSubview:segmentedControl];
    
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
    else if(tableView == boxTableView)
    {
        return [orderDataBoxList count];
    }
    else if(tableView == casualTableView)
    {
        return [orderDataCasualList count];
    }
    else if(tableView == bookTableView)
    {
        return [bookDataList count];
    }
    else if(tableView == coldTableView)
    {
        return [coldDataList count];
    }
    else if(tableView == hotTableView)
    {
        return [hotDataList count];
    }
}

#pragma mark-----------------初始化TableView cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == orderTableView || tableView == boxTableView || tableView == casualTableView)
    {
        static NSString *queueTableIdentifier = @"HuntOrder";
        HuntOrderCell *cell = (HuntOrderCell *)[tableView dequeueReusableCellWithIdentifier:queueTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HuntOrder" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        if(tableView == orderTableView)
        {
            //cell.picLogo
        }
        else if(tableView == boxTableView)
        {
            
        }
        else if(tableView == casualTableView)
        {
            
        }
        return cell;
    }
    else
    {
        static NSString *queueTableIdentifier = @"HuntBook";
        HuntBookCell *cell = (HuntBookCell *)[tableView dequeueReusableCellWithIdentifier:queueTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HuntBook" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        if(tableView == bookTableView)
        {
            
        }
        else if(tableView == coldTableView)
        {
            
        }
        else if(tableView == hotTableView)
        {
            
        }
    }
    return nil;
}

-(IBAction)enterClick:(id)sender
{
    
}

-(IBAction)plusAdd:(id)sender
{
    
}

-(IBAction)plusSub:(id)sender
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
