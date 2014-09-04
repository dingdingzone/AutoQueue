//
//  UserUpdateViewController.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-9-4.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "BaseViewController.h"

@interface UserUpdateViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UITextField *passOld;
@property (weak, nonatomic) IBOutlet UITextField *passNew;
@property (weak, nonatomic) IBOutlet UITextField *passConfirm;

@property (nonatomic,retain) QueueAppDelegate * myDelegate;

-(IBAction)enterClick:(id)sender;

@end
