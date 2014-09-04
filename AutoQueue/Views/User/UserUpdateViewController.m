//
//  UserUpdateViewController.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-9-4.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "UserUpdateViewController.h"
#import "UINavigationItem+custom.h"
#import "User.h"
#import "StringUtil.h"
#import "UserUpdateService.h"
#import "ProSetting.h"
@interface UserUpdateViewController ()

@end

@implementation UserUpdateViewController

@synthesize myDelegate;
@synthesize userName;
@synthesize userPhone;
@synthesize passOld;
@synthesize passNew;
@synthesize passConfirm;

User *userObj;
UserUpdateService *userUpdateService;

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
    userName.delegate = self;
    userPhone.delegate = self;
    passOld.delegate = self;
    passNew.delegate = self;
    passConfirm.delegate = self;
    
    userUpdateService = [[UserUpdateService alloc] init];
    
    [super viewDidLoad];
    [ProSetting setNaviTitle:@"修改资料" :self];
	// Do any additional setup after loading the view.
    self.view.layer.backgroundColor = [ProSetting getColorByStr:@"f5f5f5"].CGColor;
    
    
    myDelegate = [[UIApplication sharedApplication] delegate];
    userObj = myDelegate.userObj;
    userName.text = [NSString stringWithFormat:@"%@",[userObj userName]];
    userPhone.text = [NSString stringWithFormat:@"%@" ,[userObj mobileNbr]];
    
}

-(void)backToIndex
{
    //do something.
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    float height = 216.0;
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

-(IBAction)enterClick:(id)sender
{
    if(![StringUtil isNullString:userName.text,nil])
    {
        [StringUtil tipsInfo:@"修改资料出错" :@"用户名不能为空"];
        [userName becomeFirstResponder];
    }
    else if(![StringUtil isNullString:userPhone.text,nil])
    {
        [StringUtil tipsInfo:@"修改资料出错" :@"用户手机不能为空"];
        [userPhone becomeFirstResponder];
    }
    else if(![StringUtil isNullString:passOld.text,nil])
    {
        [StringUtil tipsInfo:@"修改资料出错" :@"旧密码不能为空"];
        [passOld becomeFirstResponder];
    }
    else if(![StringUtil isNullString:passNew.text,nil])
    {
        [StringUtil tipsInfo:@"修改资料出错" :@"新密码不能为空"];
        [passNew becomeFirstResponder];
    }
    else if(![StringUtil isNullString:passConfirm.text,nil])
    {
        [StringUtil tipsInfo:@"修改资料出错" :@"确认新密码不能为空"];
        [passConfirm becomeFirstResponder];
    }
    else
    {
        NSString *result = [userUpdateService updateUserInfo:[userObj userId] :userName.text :userPhone.text :passOld.text :passNew.text :passConfirm.text];
        if([result isEqualToString:@"false"])
        {
            [StringUtil tipsInfo:@"修改资料出错" :@"未能成功修改资料信息"];
        }
        else if([result isEqualToString:@"123"])
        {
            [StringUtil tipsInfo:@"修改资料出错" :@"输入的旧密码错误"];
        }
        else if([result isEqualToString:@"true"])
        {
            userObj.userName = userName.text;
            userObj.mobileNbr = userPhone.text;
            UIAlertView *uiAlertView = [[UIAlertView alloc] initWithTitle:@"修改资料成功" message:@"您的资料已修改" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [uiAlertView show];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
