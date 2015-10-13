//
//  PublishViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/10/6.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"
#import "DSXUserStatus.h"

@interface PublishViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
    @private
    UILabel *_contentPlaceHolder;
}

@property(nonatomic,assign)NSInteger catid;
@property(nonatomic,retain)UITextField *titleTextField;
@property(nonatomic,retain)UITextView *contentTextView;
@property(nonatomic,retain)DSXUserStatus *userStatus;

@end