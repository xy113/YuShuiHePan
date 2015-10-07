//
//  ListViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"
#import "DSXTableView.h"
#import "DSXUserStatus.h"

@interface ListViewController : UIViewController<DSXTableViewDelegate>{
    @private
    int _page;
    NSString *_keyName;
}

@property(nonatomic,assign)NSInteger catid;
@property(nonatomic,retain)DSXTableView *mainTableView;
@property(nonatomic,retain)NSOperationQueue *operationQueue;
@property(nonatomic,retain)DSXUserStatus *userStatus;

@end
