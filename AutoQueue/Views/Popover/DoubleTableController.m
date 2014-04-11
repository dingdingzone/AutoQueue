//
//  DoubleTableController.m
//  FPPopoverDemo
//
//  Created by Lapland_Alone on 13-12-5.
//  Copyright (c) 2013年 Fifty Pixels Ltd. All rights reserved.
//

#import "DoubleTableController.h"
#import "DoubleTableService.h"
#import "StringUtil.h"

@interface DoubleTableController ()
	
@end

@implementation DoubleTableController

@synthesize parentTab;
@synthesize subTab;

int parCellSel;

DoubleTableService *doubleTableService;

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
    doubleTableService = [[DoubleTableService alloc] init];
    [doubleTableService getData];
    parCellSel = 0;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSInteger selectedIndex = 0;
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    
    [self.parentTab selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    [super viewDidAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.parentTab)
    {
        return [[doubleTableService tableData] count];
    }
    else
    {
        return [[doubleTableService subTableData] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleGray;

        //[cell setBackgroundView:backgroundViews];
        [self.subTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    UIView *backgroundViews = [[UIView alloc]initWithFrame:cell.frame];
    UIColor *ccColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    backgroundViews.backgroundColor = ccColor;
    [cell setSelectedBackgroundView:backgroundViews];
    
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
    
    //cell.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    //cell.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    
    NSString * labelText;
    
    if(tableView==self.parentTab)
    {
        labelText=[[doubleTableService tableData] objectAtIndex:indexPath.row];
    }
    else
    {
       [cell setBackgroundView:backgroundViews];
       cell.textLabel.backgroundColor = ccColor;
       cell.textLabel.textColor = [UIColor blackColor];
       labelText=[[doubleTableService subTableData] objectAtIndex:indexPath.row];
    }
    cell.textLabel.text =labelText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSUInteger row = indexPath.row;
    // NSString *rowValue = [listData objectAtIndex:row];
    
   // NSString *msg = [[NSString alloc]initWithFormat:@"You selected %@", rowValue];
    int pos = indexPath.row;
    if(tableView == self.parentTab)
    {
        [doubleTableService getChangeSubAreaInfo:pos];
        parCellSel = pos;
        [self.subTab reloadData];
    }
    else if(tableView == self.subTab)
    {
        NSString *cont = [NSString stringWithFormat:@"%@-%@",[[doubleTableService tableData] objectAtIndex:parCellSel],[[doubleTableService subTableData] objectAtIndex:pos]];
        [StringUtil tipsInfo:@"" :cont];
    }

    
    //NSLog(@"array:%@",subTableData);
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];//在弹出警告后自动取消选中表视图单元
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

}
@end
