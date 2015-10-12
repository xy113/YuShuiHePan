//
//  DSXUI.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DSXNavigationController.h"
#import "LoginViewController.h"

typedef enum {
    DSXBarButtonStyleBack,
    DSXBarButtonStyleAdd,
    DSXBarButtonStyleLike,
    DSXBarButtonStyleShare,
    DSXBarButtonStyleFavorite,
    DSXBarButtonStyleRefresh
}DSXBarButtonStyle;

typedef NS_ENUM(NSInteger,DSXPopViewStyle){
    DSXPopViewStyleDefault,
    DSXPopViewStyleWarning,
    DSXPopViewStyleDone,
    DSXPopViewStyleError
};


@interface DSXUI : NSObject

+ (instancetype)sharedUI;

- (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName target:(id)target action:(SEL)action;
- (UIBarButtonItem *)barButtonWithStyle:(DSXBarButtonStyle)style target:(id)target action:(SEL)action;

- (void)showPopViewWithStyle:(DSXPopViewStyle)style Message:(NSString *)message;
- (UIView *)showLoadingViewWithMessage:(NSString *)message;
- (void)showLoginFromViewController:(UIViewController *)controller;


@end
