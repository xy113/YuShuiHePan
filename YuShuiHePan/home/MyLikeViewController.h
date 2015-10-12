//
//  MyLikeViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/10/12.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"
#import "DSXUserStatus.h"
#import "DSXTableView.h"

@interface MyLikeViewController : UIViewController<DSXTableViewDelegate>{
    @private
    int _page;
}

@property(nonatomic,retain)DSXTableView *mainTableView;
@property(nonatomic,retain)DSXUserStatus *userStatus;
@property(nonatomic,retain)NSOperationQueue *operationQueue;
@property(nonatomic,strong)NSData *tableViewData;

@end
