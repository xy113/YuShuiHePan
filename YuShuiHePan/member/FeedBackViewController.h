//
//  FeedBackViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/10/12.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"

@interface FeedBackViewController : UIViewController<UITextViewDelegate>

@property(nonatomic,retain)UITextView *textView;
@property(nonatomic,retain)UILabel *placeHolder;

@end
