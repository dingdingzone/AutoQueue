//
//  SortedSelController.m
//  AutoQueue
//
//  Created by leo on 13-12-30.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "SortedSelController.h"
#import "SortedSelectCell.h"
#import "StringUtil.h"
#import "Queue.h"

@interface SortedSelController ()

@end

@implementation SortedSelController
@synthesize queueTable;
NSMutableArray *queueData;

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
    queueTable.delegate = self;
    queueData = [[NSMutableArray alloc] init];
    NSArray *arr = [[NSArray alloc] initWithObjects:@"单人队列",@"双人队列",@"三人队列",@"四人队列",@"四人以上",nil];
    for(int i = 0;i < 5;i++)
    {
        Queue *queue = [Queue alloc];
        queue.queueName = [arr objectAtIndex:i];
        [queueData addObject:queue];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [queueData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SortedSelectCell";
    SortedSelectCell *cell = (SortedSelectCell *)[self.queueTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SortedSelectCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.queueLabel.text = [[queueData objectAtIndex:indexPath.row] queueName];
    return cell;
}

-(IBAction)enterClick:(id)sender
{
    
}

@end
