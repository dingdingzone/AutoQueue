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

@implementation DoubleTableController

@synthesize parentTab;
@synthesize subTab;
@synthesize delegate=_delegate;
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

#pragma mark ----------------隐藏tableview没有数据的cell
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
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
//        分割线
//        [self.subTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    UIView *backgroundViews = [[UIView alloc]initWithFrame:cell.frame];
    UIColor *ccColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    backgroundViews.backgroundColor = ccColor;
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    
//    cell.backgroundColor = ccColor;
//    cell.backgroundColor = ccColor;
    
//    换行线
//    tableView.separatorColor = [UIColor blueColor];
    
    NSString * labelText;
   
    if(tableView==self.parentTab)
    {
        [cell setSelectedBackgroundView:backgroundViews];

        labelText=[[doubleTableService tableData] objectAtIndex:indexPath.row];
    }
    else
    {
       [self setExtraCellLineHidden:tableView];
       tableView.backgroundColor=ccColor;
       [cell setBackgroundView:backgroundViews];
//       cell.textLabel.backgroundColor = ccColor;
//       cell.textLabel.textColor = [UIColor blackColor];
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
        [self.delegate selectedTableRow:indexPath.row];
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
