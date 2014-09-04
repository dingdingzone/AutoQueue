//
//  RegisterViewController.m
//  AutoQueue
//
//  Created by Lapland_Alone on 14-9-4.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import "RegisterViewController.h"
#import "UINavigationItem+custom.h"
#import "StringUtil.h"
#import "RegeisterService.h"
#import "ProSetting.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

RegeisterService *regeisterService;

@synthesize regPhone;
@synthesize regValiCode;
@synthesize isReadPro;
@synthesize regSegment;

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
    regPhone.delegate = self;
    regValiCode.delegate = self;
//    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
//    [backButton addTarget:self action:@selector(backToIndex) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationItem setUIBarButtonItem:self.navigationItem : backButton];
    [super viewDidLoad];
    [ProSetting setNaviTitle:@"注册自助排队" :self];
	// Do any additional setup after loading the view.
    self.view.layer.backgroundColor = [ProSetting getColorByStr:@"f5f5f5"].CGColor;
    regSegment.tintColor = [ProSetting getColorByStr:@"cd4e61"];
    
    regeisterService = [RegeisterService alloc];
    isReadPro.on = NO;
    UILabel *regPhoneTxt = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 47, 30)];
    regPhoneTxt.font = [UIFont fontWithName:@"Helvetica" size:12];
    regPhoneTxt.text = @"  手机号:";
    regPhone.leftView = regPhoneTxt;
    regPhone.leftViewMode = UITextFieldViewModeAlways;
    regPhone.placeholder = @"输入11位手机号";
    
    regValiCode.placeholder = @"输入验证码";
    
    
}
-(void)backToIndex
{
    //do something.
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)registerClick:(id)sender
{
    [self removeNavigationViewController];
    /*
    if(![StringUtil isNullString:regPhone.text,nil])
    {
        [StringUtil tipsInfo:@"用户注册失败" :@"请输入手机号码"];
        [regPhone becomeFirstResponder];
    }
    else if(![StringUtil isNullString:regValiCode.text,nil])
    {
        [StringUtil tipsInfo:@"用户注册失败" :@"请输入验证码"];
        [regValiCode becomeFirstResponder];
    }
    else if(isReadPro.on == NO)
    {
        [StringUtil tipsInfo:@"用户注册失败" :@"您还没有阅读自助排队用户协议"];
    }
    else if(![StringUtil validatePhoneNum:regPhone.text])
    {
        [StringUtil tipsInfo:@"用户注册失败" :@"您输入的手机号码不正确！"];
        regPhone.text = @"";
    }
    else
    {
        NSString *result = [regeisterService regUser:regPhone.text :regValiCode.text];
        if([result isEqualToString:@"false"])
        {
            [StringUtil tipsInfo:@"用户注册失败" :@"未能成功注册用户账户"];
        }
        else if([result isEqualToString:@"123"])
        {
            [StringUtil tipsInfo:@"用户注册失败" :@"手机号已在系统中注册"];
        }
        else
        {
            UIAlertView *uiAlertView = [[UIAlertView alloc] initWithTitle:@"用户注册成功" message:@"您的账户已注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [uiAlertView show];
        }
    }*/
}

- (IBAction)getValiCodeClick:(id)sender
{
    regValiCode.text = @"123456";
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
