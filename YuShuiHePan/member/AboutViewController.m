//
//  AboutViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/10/12.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController
@synthesize webView;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"关于"];
    [self.view setBackgroundColor:DSXCOLORWHITE];
    
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.backgroundColor = DSXCOLORWHITE;
    [self.view addSubview:self.webView];
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
