//
//  MyArticleViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/10/9.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"
#import "DSXUserStatus.h"
#import "DSXTableView.h"

@interface MyArticleViewController : UIViewController<DSXTableViewDelegate>{
    @private
    int _page;
}

@property(nonatomic,retain)DSXTableView *mainTableView;
@property(nonatomic,retain)DSXUserStatus *userStatus;
@property(nonatomic,retain)NSOperationQueue *operationQueue;

@end