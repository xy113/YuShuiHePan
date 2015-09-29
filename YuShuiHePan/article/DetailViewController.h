//
//  DetailViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property(nonatomic,assign)NSInteger aid;
@property(nonatomic,retain)UIWebView *webView;
@property(nonatomic,retain)NSOperationQueue *operationQueue;

@end
