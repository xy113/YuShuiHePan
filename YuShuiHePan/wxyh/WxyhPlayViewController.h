//
//  WxyhPlayViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/29.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"
#import "DSXUserStatus.h"

@interface WxyhPlayViewController : UIViewController{
    
}

@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString *articleTitle;
@property(nonatomic,retain)UIWebView *webView;
@property(nonatomic,retain)DSXUserStatus *userStatus;

@end
