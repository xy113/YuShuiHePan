//
//  ShowMessageViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/10/12.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"
#import "DSXUserStatus.h"

@interface ShowMessageViewController : UIViewController

@property(nonatomic,assign)NSInteger mid;
@property(nonatomic,retain)UIWebView *webView;
@property(nonatomic,retain)DSXUserStatus *userStatus;

@end
