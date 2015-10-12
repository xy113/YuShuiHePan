//
//  DSXShare.m
//  YuShuiHePan
//
//  Created by songdewei on 15/10/12.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "DSXShare.h"

@implementation DSXShare

- (void)showActionSheetInView:(UIView *)view Params:(NSMutableDictionary *)params{
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[params objectForKey:@"content"]
                                       defaultContent:@"说点什么吧"
                                                image:[ShareSDK imageWithUrl:[params objectForKey:@"image"]]
                                                title:[params objectForKey:@"title"]
                                                  url:[params objectForKey:@"url"]
                                          description:[params objectForKey:@"description"]
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:view arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                }
                            }];
}

@end
