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
    [self.view setBackgroundColor:DSXCOLORGRAY];
    
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SWIDTH - 180)/2, 30, 180, 197)];
    [imageView setImage:[UIImage imageNamed:@"logo.png"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:imageView];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake((SWIDTH - 100)/2, 240, 100, 30)];
    versionLabel.text = @"V1.0.0";
    versionLabel.font = [UIFont fontWithName:DSXFontStyleDemilight size:18.0];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SHEIGHT-120, SWIDTH-20, 30)];
    bottomLabel.text = @"网址:http://yushuihepan.com  QQ:307718818";
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = [UIFont fontWithName:DSXFontStyleDemilight size:14.0];
    [self.view addSubview:bottomLabel];
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
