//
//  SelPickerView.h
//  AutoQueue
//
//  Created by leo on 13-12-18.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SelPickerView : UIActionSheet<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *selCtrl;

@property (strong, nonatomic) NSString *selValue;

@property int selIndex;

- (id)initWithTitle:(NSString *)title :(NSMutableArray *)dataArr delegate:(id)delegate;

- (void)showInView:(UIView *)view;

@end
