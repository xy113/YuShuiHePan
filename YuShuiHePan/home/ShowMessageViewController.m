//
//  ShowMessageViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/10/12.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "ShowMessageViewController.h"

@implementation ShowMessageViewController
@synthesize mid;
@synthesize webView;
@synthesize userStatus;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"消息中心"];
    [self.view setBackgroundColor:DSXCOLORWHITE];
    self.userStatus = [[DSXUserStatus alloc] init];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.backgroundColor = DSXCOLORWHITE;
    [self.view addSubview:self.webView];
    
    NSData *data = [[DSXUtil sharedUtil] dataWithURL:[SITEAPI stringByAppendingFormat:@"&ac=my&op=getmessage&uid=%ld&mid=%ld",(long)self.userStatus.uid,(long)self.mid]];
    id message = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([message isKindOfClass:[NSDictionary class]]) {
        NSString *html = @"<article style=\"font-size:16px; line-height:1.5; padding:0 5px;\">";
        html = [html stringByAppendingFormat:@"<p>%@</p>",[message objectForKey:@"message"]];
        html = [html stringByAppendingFormat:@"<p>%@</p>",[message objectForKey:@"dateline"]];
        html = [html stringByAppendingString:@"</article>"];
        [self.webView loadHTMLString:html baseURL:nil];
    }
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
