//
//  RegeisterViewController.h
//  AutoQueue
//
//  Created by alone on 13-11-21.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegeisterViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *regPhone;
@property (weak, nonatomic) IBOutlet UITextField *regValiCode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *regSegment;

@property (weak, nonatomic) IBOutlet UISwitch *isReadPro;

- (IBAction)getValiCodeClick:(id)sender;

- (IBAction)regClick:(id)sender;

@end
