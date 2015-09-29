//
//  RegisterViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/23.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,retain)UITextField *usernameField;
@property(nonatomic,retain)UITextField *passwordField;
@property(nonatomic,retain)UITextField *mobileField;
@property(nonatomic,retain)UIButton *registerButton;

@end
