//
//  WxyhPlayViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/29.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "WxyhPlayViewController.h"
#import "Common.h"

@implementation WxyhPlayViewController
@synthesize ID;
@synthesize webView;

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    UIBarButtonItem *shareButton = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleShare target:self action:nil];
    UIBarButtonItem *favorButton = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleFavorite target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[shareButton,favorButton];
    
    CGRect frame = self.view.frame;
    self.webView = [[UIWebView alloc] initWithFrame:frame];
    self.webView.mediaPlaybackAllowsAirPlay = NO;
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.webView.backgroundColor = [UIColor blackColor];
    NSString *urlString = [SITEAPI stringByAppendingFormat:@"&ac=wxyh&op=play&id=%ld",(long)self.ID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
