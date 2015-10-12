//
//  DSXUtil.m
//  YuShuiHePan
//
//  Created by songdewei on 15/10/5.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "DSXUtil.h"

@implementation DSXUtil

+ (instancetype)sharedUtil{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (NSData *)dataWithURL:(NSString *)urlString{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return data;
}

- (NSData *)sendDataForURL:(NSString *)urlString params:(NSMutableDictionary *)params{
    NSString *postString = @"";
    for (NSString *key in [params allKeys]) {
        NSString *value = [params objectForKey:key];
        postString = [postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    if (postString.length > 0) {
        postString = [postString substringToIndex:postString.length-1];
    }
    NSError *error;
    NSURLResponse *urlResponse;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
}

- (void)addFavoriteWithParams:(NSMutableDictionary *)params{
    NSData *data = [self sendDataForURL:[SITEAPI stringByAppendingString:@"&ac=misc&op=addfavorite"] params:params];
    if ([data length] > 0) {
        [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDone Message:@"收藏成功"];
    }
}

@end
