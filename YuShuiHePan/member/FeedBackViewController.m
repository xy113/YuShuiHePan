//
//  FeedBackViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/10/12.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "FeedBackViewController.h"

@implementation FeedBackViewController
@synthesize textView;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:DSXCOLORWHITE];
    [self setTitle:@"反馈给玉水河畔"];
    
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    CGRect frame = self.view.frame;
    frame.size.height = 300;
    self.textView = [[UITextView alloc] initWithFrame:frame];
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont fontWithName:DSXFontStyleDemilight size:16.0];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
    
    self.placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 50, 20)];
    self.placeHolder.text = @"请输入反馈信息:";
    self.placeHolder.textColor = [UIColor grayColor];
    self.placeHolder.font = [UIFont fontWithName:DSXFontStyleDemilight size:16.0];
    [self.placeHolder sizeToFit];
    [self.textView addSubview:self.placeHolder];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)send{
    [self.view endEditing:YES];
    NSString *message = self.textView.text;
    if (message.length < 1) {
        [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDefault Message:@"不能发送空信息"];
    }else {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:message forKey:@"message"];
        NSData *returnData = [[DSXUtil sharedUtil] sendDataForURL:[SITEAPI stringByAppendingString:@"&ac=feedback"] params:params];
        if (returnData.length > 0) {
            [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDone Message:@"发送成功"];
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(back) userInfo:nil repeats:NO];
        }else {
            [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleError Message:@"系统错误，请稍后再试"];
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.textView.text.length > 1) {
        self.placeHolder.hidden = YES;
    }else {
        self.placeHolder.hidden = NO;
    }
}

@end
