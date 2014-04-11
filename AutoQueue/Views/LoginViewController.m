//
//  LoginViewController.m
//  AutoQueue
//
//  Created by alone on 13-11-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import "LoginViewController.h"
#import "UINavigationItem+custom.h"
#import "LoginService.h"
#import "StringUtil.h"
#import "User.h"
#import "ProSetting.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize userName;
@synthesize passWord;
@synthesize loginBtn;
@synthesize myDelegate;

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
    myDelegate = [[UIApplication sharedApplication] delegate];
    //myDelegate.userNameApp=@"123";
    userName.delegate = self;
    passWord.delegate = self;
    
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [backButton addTarget:self action:@selector(backToIndex) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setUIBarButtonItem:self.navigationItem : backButton];

    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户2.png"]];
    image.frame = CGRectMake(0, 0, 16, 16);
    userName.rightView=image;
    userName.rightViewMode = UITextFieldViewModeAlways;
    userName.Placeholder  = @"用户/Username";
    userName.backgroundColor = [UIColor whiteColor];
    
    UIImageView *passImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"锁.png"]];
    passImage.frame = CGRectMake(0, 0, 16, 16);
    passWord.rightView=passImage;
    passWord.rightViewMode = UITextFieldViewModeAlways;
    passWord.Placeholder  = @"密码/Password";
    passWord.backgroundColor = [UIColor whiteColor];
    passWord.secureTextEntry = YES;

    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"登录背景.jpg"] ];
    
    
    [super viewDidLoad];
    [ProSetting setNaviTitle:@"自助排队" :self];
	// Do any additional setup after loading the view.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction) loginAction:(id)sender
{
    //NSString * name=myDelegate.userNameApp;
    //userName.text=name;
    LoginService * loginService=[LoginService alloc];
    if(![StringUtil isNullString:userName.text,passWord.text,nil])
    {
        [StringUtil tipsInfo:@"登录失败" :@"用户名或密码不能为空!"];
        return ;
    }
    //UIActivityIndicatorView *indicator = [StringUtil loading:self];
    bool result = [loginService userLogin :userName.text :passWord.text];
    
    //[indicator stopAnimating];
    if(result)
    {
        [self performSegueWithIdentifier:@"Segue_LoginSuccess" sender:self];
    }
    else
    {
        [StringUtil tipsInfo:@"登录失败" :@"用户名或密码错误!"];
    }
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

@end


 //UIImage * loginBtnImg = [UIImage imageNamed:@"蓝色按键.9.png"];
 
 // loginBtnImg=[loginBtnImg scaleToSize:CGSizeMake(120, 35)];
 
 // UIImage * regesiterBtnImg = [UIImage imageNamed:@"白色按键.9.png"];
 
 //regesiterBtnImg=[regesiterBtnImg scaleToSize:CGSizeMake(120, 35)];
 
 // buttonImage = [buttonImage stretchableImageWithLeftCapWidth:floorf(buttonImage.size.width/2) topCapHeight:floorf(buttonImage.size.height/2)];
 
 // [loginBtn setBackgroundImage:loginBtnImg forState:UIControlStateNormal];
 //［regesiter］
 //  [loginBtn setBackgroundImage:[UIImage imageNamed:@"蓝色按键.9.png"] forState:UIControlStateNormal];
 //  loginBtn.frame = CGRectMake(0, 0, 60, 20);
 
 //  UIImage * navigationImage = [UIImage imageNamed:@"向左箭头.png" ];
 
 //UIImageView * navigationImageView = [[UIImageView alloc] initWithImage:navigationImage];
 
 //[self.navigationController  setBackgroundImage:[UIImage imageNamed:@"__导航条背景图__"] ];
 //UITextField * text = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
 //[self.superView addSubview:text];    //CGRect rect = userName.frame;
 //rect.size.height = 50.0f;
 //userName=text;
 //userName.font = [UIFont fontWithName:@"Arial" size:16.0f];
 
 //[self.navigationItem changeStyle:self.navigationItem];

 //UIButton * backButton = [UIButton buttonWithType:100 addTarget:self action:@selector(backToIndex) forControlEvents:UIControlEventTouchUpInside];


 
