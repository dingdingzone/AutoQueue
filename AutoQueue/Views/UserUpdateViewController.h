//
//  UserUpdateViewController.h
//  AutoQueue
//
//  Created by leo on 13-12-16.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueueAppDelegate.h"

@interface UserUpdateViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UITextField *passOld;
@property (weak, nonatomic) IBOutlet UITextField *passNew;
@property (weak, nonatomic) IBOutlet UITextField *passConfirm;

@property (nonatomic,retain) QueueAppDelegate * myDelegate;

-(IBAction)enterClick:(id)sender;

@end
