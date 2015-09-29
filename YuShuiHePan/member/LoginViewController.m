//
//  LoginViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/22.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "LoginViewController.h"
#import "DSXNavigationController.h"
#import "RegisterViewController.h"
#import "Common.h"

@implementation LoginViewController
@synthesize usernameField;
@synthesize passwordField;
@synthesize loginButton;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pink.png"]]];
    
    UIView *inputView;
    CGRect frame;
    
    self.usernameField = [[UITextField alloc] init];
    self.usernameField.delegate = self;
    self.usernameField.placeholder = @"请输入用户名或手机号:";
    self.usernameField.returnKeyType = UIReturnKeyDone;
    frame = CGRectMake(20, 80, SWIDTH-40, 50);
    inputView = [self inputViewWithFrame:frame Image:@"icon-username.png" textField:self.usernameField];
    [self.view addSubview:inputView];
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.delegate = self;
    self.passwordField.placeholder = @"请输入密码:";
    self.passwordField.secureTextEntry = YES;
    self.passwordField.returnKeyType = UIReturnKeyDone;
    frame = CGRectMake(20, 140, SWIDTH-40, 50);
    inputView = [self inputViewWithFrame:frame Image:@"icon-lock.png" textField:self.passwordField];
    [self.view addSubview:inputView];
    
    self.loginButton = [self buttonWithTitle:@"登录"];
    self.loginButton.frame = CGRectMake(20, 210, SWIDTH-40, 50);
    [self.loginButton setBackgroundColor:[UIColor colorWithRed:0.05 green:0.38 blue:0.50 alpha:1.00]];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"loginbuttonbg.png"] forState:UIControlStateHighlighted];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.loginButton];
    
    UIButton *registerButton = [self buttonWithTitle:@"注册新账号"];
    registerButton.frame = CGRectMake(20, 310, SWIDTH-40, 50);
    [registerButton setBackgroundColor:[UIColor whiteColor]];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"cancelbuttonbg.png"] forState:UIControlStateHighlighted];
    [registerButton addTarget:self action:@selector(showRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UIButton *cancelButton = [self buttonWithTitle:@"取消"];
    cancelButton.frame = CGRectMake(20, 380, SWIDTH-40, 50);
    [cancelButton setBackgroundColor:[UIColor whiteColor]];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cancelbuttonbg.png"] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (UIButton *)buttonWithTitle:(NSString *)title{
    UIButton *button = [[UIButton alloc] init];
    button.layer.cornerRadius = 5.0;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (UIView *)inputViewWithFrame:(CGRect)frame Image:(NSString *)imageName textField:(UITextField *)textField{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [imageView setFrame:CGRectMake(10, 15, 20, 20)];
    [view addSubview:imageView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(40, 15, 1, 20)];
    line.backgroundColor = [UIColor colorWithRed:0.73 green:0.76 blue:0.79 alpha:1.00];
    [view addSubview:line];
    textField.frame = CGRectMake(50, 15, view.frame.size.width-60, 20);
    [view addSubview:textField];
    
    view.layer.cornerRadius = 5.0;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showRegister{
    RegisterViewController *registerController = [[RegisterViewController alloc] init];
    [self presentViewController:registerController animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view) {
        [self.view endEditing:YES];
    }
}
@end