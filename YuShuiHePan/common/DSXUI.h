//
//  DSXUI.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    DSXBarButtonStyleBack,
    DSXBarButtonStyleAdd,
    DSXBarButtonStyleLike,
    DSXBarButtonStyleShare,
    DSXBarButtonStyleFavorite
}DSXBarButtonStyle;

@interface DSXUI : NSObject

+ (instancetype)sharedUI;

- (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName target:(id)target action:(SEL)action;
- (UIBarButtonItem *)barButtonWithStyle:(DSXBarButtonStyle)style target:(id)target action:(SEL)action;

- (void)showPopInView:(UIView *)view Message:(NSString *)message;
- (UIView *)showLoadingInView:(UIView *)view Message:(NSString *)message;

@end
