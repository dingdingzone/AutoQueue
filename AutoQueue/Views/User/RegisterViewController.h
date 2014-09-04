//
//  RegisterViewController.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-9-4.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *regPhone;
@property (weak, nonatomic) IBOutlet UITextField *regValiCode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *regSegment;

@property (weak, nonatomic) IBOutlet UISwitch *isReadPro;

- (IBAction)getValiCodeClick:(id)sender;

- (IBAction)registerClick:(id)sender;

@end
