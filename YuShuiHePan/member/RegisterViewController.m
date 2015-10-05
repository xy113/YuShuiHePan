//
//  RegisterViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/23.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "RegisterViewController.h"
#import "DSXCommon.h"

@implementation RegisterViewController
@synthesize usernameField;
@synthesize passwordField;
@synthesize mobileField;
@synthesize registerButton;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"注册"];
    [self.view setBackgroundColor:BGCOLORGRAY];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(clickBack)];
    
    UIView *inputView;
    CGRect frame;
    
    self.usernameField = [[UITextField alloc] init];
    self.usernameField.delegate = self;
    self.usernameField.placeholder = @"请输入用户名:";
    self.usernameField.returnKeyType = UIReturnKeyDone;
    self.usernameField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    frame = CGRectMake(20, 60, SWIDTH-40, 50);
    inputView = [self inputViewWithFrame:frame Image:@"icon-username.png" textField:self.usernameField];
    [self.view addSubview:inputView];
    

    
    self.mobileField = [[UITextField alloc] init];
    self.mobileField.delegate = self;
    self.mobileField.placeholder = @"请输入手机号:";
    self.mobileField.keyboardType = UIKeyboardTypeNumberPad;
    self.mobileField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    frame = CGRectMake(20, 120, SWIDTH-40, 50);
    inputView = [self inputViewWithFrame:frame Image:@"icon-mobilefill.png" textField:self.mobileField];
    [self.view addSubview:inputView];
    
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.delegate = self;
    self.passwordField.placeholder = @"请输入密码:";
    self.passwordField.secureTextEntry = YES;
    self.passwordField.returnKeyType = UIReturnKeyDone;
    self.passwordField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    frame = CGRectMake(20, 180, SWIDTH-40, 50);
    inputView = [self inputViewWithFrame:frame Image:@"icon-lock.png" textField:self.passwordField];
    [self.view addSubview:inputView];
    
    self.registerButton = [self buttonWithTitle:@"注册"];
    self.registerButton.frame = CGRectMake(20, 250, SWIDTH-40, 50);
    self.registerButton.layer.borderColor = [UIColor colorWithRed:0.05 green:0.38 blue:0.50 alpha:1.00].CGColor;
    [self.registerButton setBackgroundColor:[UIColor colorWithRed:0.05 green:0.38 blue:0.50 alpha:1.00]];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"loginbuttonbg.png"] forState:UIControlStateHighlighted];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.registerButton];
    
    UIButton *cancelButton = [self buttonWithTitle:@"取消"];
    cancelButton.frame = CGRectMake(20, 340, SWIDTH-40, 50);
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
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:0.81 green:0.80 blue:0.81 alpha:1.00].CGColor;
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
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:0.81 green:0.80 blue:0.81 alpha:1.00].CGColor;
    return view;
}

- (void)clickBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view) {
        [self.view endEditing:YES];
    }
}

@end