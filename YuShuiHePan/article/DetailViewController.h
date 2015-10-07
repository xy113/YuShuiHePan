//
//  DetailViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentView.h"
#import "DSXCommon.h"

@interface DetailViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,assign)NSInteger aid;
@property(nonatomic,retain)UIScrollView *scrollVew;
@property(nonatomic,retain)UIWebView *contentWebView;
@property(nonatomic,retain)UIWebView *commentWebView;
@property(nonatomic,retain)CommentView *commentView;

@end
