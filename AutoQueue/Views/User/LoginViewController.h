//
//  LoginViewController.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-9-3.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "BaseViewController.h"

@protocol LoginDelegate <NSObject>

-(void) loginCallBack:(NSString *) result;

@end


@interface LoginViewController : BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (nonatomic,retain) QueueAppDelegate * myDelegate;

@property (nonatomic, assign) id<LoginDelegate> delegate;

-(IBAction) loginAction:(id)sender;
-(IBAction) registerOnClick:(id)sender;
- (void) setDelegate:(id)delegate;
@end
