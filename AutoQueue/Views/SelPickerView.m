//
//  SelPickerView.m
//  AutoQueue
//
//  Created by leo on 13-12-18.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "SelPickerView.h"
#define kDuration 0

@implementation SelPickerView

@synthesize selValue;
@synthesize selCtrl;
@synthesize titleLabel;
@synthesize selIndex;

NSMutableArray *selDataArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithTitle:(NSString *)title :(NSMutableArray *)dataArr delegate:(id)delegate
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"SelPickerView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.delegate = delegate;
        self.titleLabel.text = title;
        self.selCtrl.dataSource = self;
        self.selCtrl.delegate = self;
        selDataArr = dataArr;
        selValue = [dataArr objectAtIndex:0];
    }
    return self;
}

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [selDataArr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [selDataArr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selIndex = row;
    selValue = [selDataArr objectAtIndex:row];
}


#pragma mark - Button lifecycle

- (IBAction)cancel:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"SelPickerView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (IBAction)locate:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"SelPickerView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
