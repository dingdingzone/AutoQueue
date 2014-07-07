//
//  LoginViewController.h
//  AutoQueue
//
//  Created by alone on 13-11-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage.h"
#import "QueueAppDelegate.h"
#import "BaseViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (nonatomic,retain) QueueAppDelegate * myDelegate;

-(IBAction) loginAction:(id)sender;

@end
