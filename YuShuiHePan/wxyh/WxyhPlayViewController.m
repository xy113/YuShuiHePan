//
//  WxyhPlayViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/29.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "WxyhPlayViewController.h"
#import "DSXShare.h"

@implementation WxyhPlayViewController
@synthesize ID;
@synthesize articleTitle;
@synthesize webView;
@synthesize userStatus;

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    UIBarButtonItem *shareButton = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleShare target:self action:@selector(showShare)];
    UIBarButtonItem *favorButton = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleFavorite target:self action:@selector(addFavorite)];
    self.navigationItem.rightBarButtonItems = @[shareButton,favorButton];
    
    self.userStatus = [[DSXUserStatus alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userStatusChanged) name:UserStatusChangedNotification object:nil];
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

- (void)addFavorite{
    if (self.userStatus.isLogined) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@(self.userStatus.uid) forKey:@"uid"];
        [params setObject:@(self.ID) forKey:@"id"];
        [params setObject:@"wid" forKey:@"idtype"];
        [params setObject:self.articleTitle forKey:@"title"];
        [[DSXUtil sharedUtil] addFavoriteWithParams:params];
    }else {
        [[DSXUI sharedUI] showLoginFromViewController:self];
    }
}

- (void)showShare{
    DSXShare *share = [[DSXShare alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"高阳主持,心灵思雨,与你轻声附和" forKey:@"content"];
    [params setObject:@"http://yushuihepan.com/static/images/gaoyang.jpg" forKey:@"image"];
    [params setObject:self.articleTitle forKey:@"title"];
    [params setObject:@"http://yushuihepan.com/?mod=wxyh" forKey:@"url"];
    [params setObject:@"高阳主持,心灵思雨,与你轻声附和" forKey:@"description"];
    [share showActionSheetInView:self.view Params:params];
}

- (void)userStatusChanged{
    self.userStatus = [[DSXUserStatus alloc] init];
}

@end
