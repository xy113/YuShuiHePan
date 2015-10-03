//
//  DetailViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "DetailViewController.h"
#import "Common.h"

@implementation DetailViewController
@synthesize aid;
@synthesize webView;
@synthesize operationQueue;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:BGCOLOR];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    UIBarButtonItem *shareButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleShare target:self action:nil];
    UIBarButtonItem *likeButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleLike target:self action:nil];
    UIBarButtonItem *favorButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleFavorite target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[shareButtonItem,favorButtonItem,likeButtonItem];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.backgroundColor = BGCOLOR;
    [self.view addSubview:self.webView];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self.operationQueue addOperationWithBlock:^{
        NSString *urlString = [SITEAPI stringByAppendingFormat:@"&ac=detail&id=%ld",(long)self.aid];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [self.webView loadRequest:request];
    }];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
