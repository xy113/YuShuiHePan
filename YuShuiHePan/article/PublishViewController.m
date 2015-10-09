//
//  PublishViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/10/6.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "PublishViewController.h"

@implementation PublishViewController
@synthesize catid;
@synthesize titleTextField;
@synthesize contentTextView;
@synthesize userStatus;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"发表文章"];
    [self.view setBackgroundColor:BGCOLORGRAY];
    
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(endEdit)];
    
    self.userStatus = [[DSXUserStatus alloc] init];
    UIView *titleWrap = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SWIDTH, 50)];
    [titleWrap setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:titleWrap];
    
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, SWIDTH-20, 50)];
    self.titleTextField.placeholder = @"请输入标题:";
    self.titleTextField.font = [UIFont fontWithName:DSXFontStyleMedinum size:16.0];
    self.titleTextField.backgroundColor = [UIColor whiteColor];
    self.titleTextField.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 10);
    self.titleTextField.returnKeyType = UIReturnKeyDone;
    self.titleTextField.delegate = self;
    [titleWrap addSubview:self.titleTextField];
    
    UIView *contentWrap = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SWIDTH, 200)];
    [contentWrap setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:contentWrap];
    
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, SWIDTH-10, 190)];
    self.contentTextView.backgroundColor = [UIColor whiteColor];
    self.contentTextView.editable = YES;
    self.contentTextView.font = [UIFont fontWithName:DSXFontStyleDemilight size:16.0];
    self.contentTextView.delegate = self;
    
    _contentPlaceHolder = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 0, 0)];
    _contentPlaceHolder.text = @"请输入文章内容:";
    _contentPlaceHolder.font = [UIFont fontWithName:DSXFontStyleDemilight size:16.0];
    _contentPlaceHolder.textColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.80 alpha:1.00];
    [_contentPlaceHolder sizeToFit];
    [self.contentTextView addSubview:_contentPlaceHolder];
    [contentWrap addSubview:self.contentTextView];
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, SWIDTH-20, 50)];
    sendButton.layer.cornerRadius = 5.0;
    sendButton.layer.masksToBounds = YES;
    sendButton.backgroundColor = [UIColor redColor];
    [sendButton setTitle:@"发布" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"orange.png"] forState:UIControlStateHighlighted];
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)endEdit{
    [self.view endEditing:YES];
}

- (void)send{
    [self.view endEditing:YES];
    NSString *title = self.titleTextField.text;
    NSString *content = self.contentTextView.text;
    if ([title length] < 1) {
        [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDefault Message:@"标题不能为空"];
        return;
    }
    
    if ([content length] < 1) {
        [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDefault Message:@"内容不能为空"];
        return;
    }
    
    if (title && content) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@(self.catid) forKey:@"catid"];
        [params setObject:@(self.userStatus.uid) forKey:@"uid"];
        [params setObject:self.userStatus.username forKey:@"username"];
        [params setObject:title forKey:@"title"];
        [params setObject:content forKey:@"content"];
        NSData *data = [[DSXUtil sharedUtil] sendDataForURL:[SITEAPI stringByAppendingString:@"&ac=post&op=publish"] params:params];
        if ([data length] > 0) {
            [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDone Message:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleError Message:@"系统错误"];
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        _contentPlaceHolder.hidden = YES;
    }else {
        _contentPlaceHolder.hidden = NO;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

- (void)keyBoardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyBoardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if ([self.contentTextView isFirstResponder]) {
        CGRect frame = self.view.frame;
        frame.origin.y = keyBoardFrame.origin.y - 280;
        self.view.frame = frame;
    }else{
        CGRect frame = self.view.frame;
        frame.origin.y = 64;
        self.view.frame = frame;
    }
}

- (void)keyBoardWillHide:(NSNotification *)notification{
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    self.view.frame = frame;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view) {
        [self.view endEditing:YES];
    }
}

@end
