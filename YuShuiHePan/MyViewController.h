//
//  MyViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *mainTableView;
@property(nonatomic,retain)UIImageView *avatarView;
@end
