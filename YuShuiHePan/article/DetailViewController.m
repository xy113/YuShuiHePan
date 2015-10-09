//
//  DetailViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "DetailViewController.h"
#import "DSXNavigationController.h"
#import "LoginViewController.h"

@implementation DetailViewController
@synthesize aid;
@synthesize scrollVew;
@synthesize contentWebView;
@synthesize commentWebView;
@synthesize userStatus;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:BGCOLOR];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    UIBarButtonItem *shareButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleShare target:self action:nil];
    UIBarButtonItem *likeButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleLike target:self action:nil];
    UIBarButtonItem *favorButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleFavorite target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[shareButtonItem,favorButtonItem,likeButtonItem];
    
    self.userStatus = [[DSXUserStatus alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userStatusChanged) name:UserStatusChangedNotification object:nil];
    
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 44;
    self.scrollVew = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollVew.pagingEnabled = YES;
    self.scrollVew.contentSize = CGSizeMake(frame.size.width*2, 0);
    self.scrollVew.delegate = self;
    [self.view addSubview:self.scrollVew];
    
    NSURLRequest *request;
    NSString *urlString;
    //正文
    self.contentWebView = [[UIWebView alloc] initWithFrame:frame];
    self.contentWebView.backgroundColor = BGCOLOR;
    self.contentWebView.delegate = self;
    [self.scrollVew addSubview:self.contentWebView];
    
    urlString = [SITEAPI stringByAppendingFormat:@"&ac=detail&id=%ld",(long)self.aid];
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.contentWebView loadRequest:request];
    
    //评论列表
    frame.origin.x = frame.size.width;
    self.commentWebView = [[UIWebView alloc] initWithFrame:frame];
    self.commentWebView.backgroundColor = DSXCOLORWHITE;
    [self.scrollVew addSubview:self.commentWebView];
    
    urlString = [SITEAPI stringByAppendingFormat:@"&ac=comment&idtype=aid&id=%ld",(long)self.aid];
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.commentWebView loadRequest:request];
    
    //评论窗口
    UITextView *commTextField = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, SWIDTH-90, 34)];
    commTextField.text = @"我来说两句..";
    commTextField.font = [UIFont fontWithName:DSXFontStyleDemilight size:14.0];
    commTextField.editable = NO;
    commTextField.layer.cornerRadius = 3.0;
    commTextField.layer.masksToBounds = YES;
    commTextField.layer.borderWidth = 0.6;
    commTextField.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.00].CGColor;
    [self.navigationController.toolbar addSubview:commTextField];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCommentView)];
    [commTextField addGestureRecognizer:singleTap];
    
    //评论数
    commButton = [[UIButton alloc] initWithFrame:CGRectMake(SWIDTH-70, 5, 60, 34)];
    commButton.tag = 300;
    commButton.layer.cornerRadius = 4.0;
    commButton.layer.masksToBounds = YES;
    commButton.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.00].CGColor;
    commButton.layer.borderWidth = 0.6;
    commButton.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    commButton.titleLabel.font = [UIFont fontWithName:DSXFontStyleDemilight size:16.0];
    [commButton setTitle:@"0" forState:UIControlStateNormal];
    [commButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [commButton addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.toolbar addSubview:commButton];
    
    self.commentView = [[CommentView alloc] init];
    self.commentView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
    //[self.commentView remove];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showCommentView{
    if (self.userStatus.isLogined) {
        [self.commentView show];
    }else {
        LoginViewController *loginView = [[LoginViewController alloc] init];
        DSXNavigationController *nav = [[DSXNavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)switchButton:(UIButton *)sender{
    UIButton *button = sender;
    CGPoint offset = self.scrollVew.contentOffset;
    if (button.tag == 300) {
        button.tag = 301;
        offset.x = SWIDTH;
        [button setTitle:@"原文" forState:UIControlStateNormal];
    }else {
        button.tag = 300;
        offset.x = 0;
        NSString *title = [NSString stringWithFormat:@"%ld",(long)commentNum];
        [button setTitle:title forState:UIControlStateNormal];
    }
    [self.scrollVew setContentOffset:offset animated:YES];
}

- (void)userStatusChanged{
    self.userStatus = [[DSXUserStatus alloc] init];
}

#pragma mark - webView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (webView == self.contentWebView) {
        NSString *stringNum = [webView stringByEvaluatingJavaScriptFromString:@"getCommentNum()"];
        [commButton setTitle:stringNum forState:UIControlStateNormal];
        commentNum = [stringNum intValue];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDefault Message:@"网络连接失败"];
}

- (void)sendComment{
    NSString *message = self.commentView.textView.text;
    if (message.length > 2) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@(self.aid) forKey:@"id"];
        [params setObject:@"aid" forKey:@"idtype"];
        [params setObject:@(self.userStatus.uid) forKey:@"uid"];
        [params setObject:self.userStatus.username forKey:@"username"];
        [params setObject:message forKey:@"message"];
        NSData *data = [[DSXUtil sharedUtil] sendDataForURL:[SITEAPI stringByAppendingString:@"&ac=comment&op=save"] params:params];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if ([result isEqualToString:@"1"]) {
            commentNum++;
            NSString *title = [NSString stringWithFormat:@"%ld",(long)commentNum];
            [commButton setTitle:title forState:UIControlStateNormal];
            
            self.commentView.textView.text = @"";
            [self.commentWebView reload];
            [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDone Message:@"评论发表成功"];
        }else{
            [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleError Message:@"内部系统错误"];
        }
        [self.commentView hide];
    }else{
        [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleWarning Message:@"不能发表空评论"];
    }
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollVew == self.scrollVew) {
        if (scrollVew.contentOffset.x == SWIDTH) {
            commButton.tag = 301;
            [commButton setTitle:@"原文" forState:UIControlStateNormal];
        }else {
            commButton.tag = 300;
            NSString *stringNum = [NSString stringWithFormat:@"%ld",(long)commentNum];
            [commButton setTitle:stringNum forState:UIControlStateNormal];
        }
    }
}

@end
