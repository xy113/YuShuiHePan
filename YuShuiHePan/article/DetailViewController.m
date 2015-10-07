//
//  DetailViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
@synthesize aid;
@synthesize scrollVew;
@synthesize contentWebView;
@synthesize commentWebView;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:BGCOLOR];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    UIBarButtonItem *shareButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleShare target:self action:nil];
    UIBarButtonItem *likeButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleLike target:self action:nil];
    UIBarButtonItem *favorButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleFavorite target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[shareButtonItem,favorButtonItem,likeButtonItem];
    
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 44;
    self.scrollVew = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollVew.pagingEnabled = YES;
    self.scrollVew.contentSize = CGSizeMake(frame.size.width*2, 0);
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
    [self.scrollVew addSubview:self.commentWebView];
    
    urlString = [SITEAPI stringByAppendingFormat:@"&ac=comment&idtype=aid&aid=%ld",(long)self.aid];
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
    
    UIButton *commButton = [[UIButton alloc] initWithFrame:CGRectMake(SWIDTH-70, 5, 60, 34)];
    commButton.layer.cornerRadius = 4.0;
    commButton.layer.masksToBounds = YES;
    commButton.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.00].CGColor;
    commButton.layer.borderWidth = 0.6;
    commButton.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    [commButton setTitle:@"0" forState:UIControlStateNormal];
    [commButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.navigationController.toolbar addSubview:commButton];
    
    self.commentView = [[CommentView alloc] init];
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
    [self.commentView show];
}

#pragma mark - webView delegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[DSXUI sharedUI] showPopInView:self.navigationController.view Message:@"网络连接失败"];
}

@end
