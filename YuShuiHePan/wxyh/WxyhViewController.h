//
//  WxyhViewController.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/29.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCommon.h"
#import "DSXTableView.h"

@interface WxyhViewController : UIViewController<DSXTableViewDelegate>{
    @private
    int _page;
}

@property(nonatomic,retain)DSXTableView *mainTableView;
@property(nonatomic,retain)NSOperationQueue *operationQueue;

@end