//
//  LoginViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/22.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"
#import "DSXUserStatus.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,DSXUserStatusDelegate>

@property(nonatomic,retain)UITextField *usernameField;
@property(nonatomic,retain)UITextField *passwordField;
@property(nonatomic,retain)UIButton *loginButton;
@property(nonatomic,retain)DSXUserStatus *userStatus;

@end
