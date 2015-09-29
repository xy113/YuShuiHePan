//
//  DSXUI.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "DSXUI.h"

@implementation DSXUI

+ (instancetype)sharedUI{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName target:(id)target action:(SEL)action{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
    return barButtonItem;
}

- (UIBarButtonItem *)barButtonWithStyle:(DSXBarButtonStyle)style target:(id)target action:(SEL)action{
    NSString *imageName;
    switch (style) {
        case DSXBarButtonStyleBack:
            imageName = @"icon-back.png";
            break;
        case DSXBarButtonStyleFavorite:
            imageName = @"icon-favorite.png";
            break;
        case DSXBarButtonStyleLike:
            imageName = @"icon-like.png";
            break;
        case DSXBarButtonStyleShare:
            imageName = @"icon-share.png";
            break;
        case DSXBarButtonStyleAdd:
            imageName = @"icon-add.png";
            break;
        default:
            break;
    }
    return [self barButtonWithImage:imageName target:target action:action];
}

- (void)showPopInView:(UIView *)view Message:(NSString *)message{
    UIView *popView = [[UIView alloc] init];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-info.png"]];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [popView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.0];
    [label sizeToFit];
    [popView addSubview:label];
    popView.backgroundColor = [UIColor blackColor];
    popView.layer.cornerRadius = 5.0;
    popView.layer.masksToBounds = YES;
    popView.frame = CGRectMake(0, 0, label.frame.size.width+20, label.frame.size.height+67);
    popView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    
    [imageView setFrame:CGRectMake((popView.frame.size.width-32)/2, 10, 32, 32)];
    
    CGRect frame;
    frame = label.frame;
    frame.origin.x = 10;
    frame.origin.y = 52;
    [label setFrame:frame];
    [view addSubview:popView];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hidePopView:) userInfo:popView repeats:NO];
}

- (void)hidePopView:(NSTimer *)timer{
    UIView *popView = [timer userInfo];
    [popView removeFromSuperview];
}

- (UIView *)showLoadingInView:(UIView *)view Message:(NSString *)message{
    UIView *popView = [[UIView alloc] init];
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [popView addSubview:indicatorView];
    [indicatorView startAnimating];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.0];
    [label sizeToFit];
    [popView addSubview:label];
    popView.backgroundColor = [UIColor blackColor];
    popView.layer.cornerRadius = 5.0;
    popView.layer.masksToBounds = YES;
    popView.frame = CGRectMake(0, 0, label.frame.size.width+20, label.frame.size.height+67);
    popView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    
    [indicatorView setFrame:CGRectMake((popView.frame.size.width-40)/2, 10, 40, 40)];
    CGRect frame;
    frame = label.frame;
    frame.origin.x = 10;
    frame.origin.y = 52;
    [label setFrame:frame];
    [view addSubview:popView];
    return popView;
}

@end