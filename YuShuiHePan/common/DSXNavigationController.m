//
//  DSXNavigationController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "DSXNavigationController.h"
#import "Config.h"

@implementation DSXNavigationController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self.navigationBar setHidden:NO];
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"pink.png"] forBarMetrics:UIBarMetricsDefault];
}
@end
