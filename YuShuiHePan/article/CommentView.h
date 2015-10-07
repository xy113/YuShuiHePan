//
//  CommentView.h
//  YuShuiHePan
//
//  Created by songdewei on 15/10/6.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"

@interface CommentView : UIView<UITextViewDelegate>{
    @private
    CGFloat _width;
    CGFloat _height;
    CGRect _frame;
}

@property(nonatomic,assign)NSInteger aid;
@property(nonatomic,retain)UIView *postView;
@property(nonatomic,retain)UITextView *textView;
@property(nonatomic,retain)UIButton *sendButton;
@property(nonatomic,retain)UIView *modalView;

- (instancetype)init;
- (void)show;
- (void)hide;
- (void)remove;

@end
