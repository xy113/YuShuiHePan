//
//  DSXURLConnection.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "DSXURLConnection.h"

@implementation DSXURLConnection

+ (NSData *)dataWithURL:(NSString *)urlString{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    return [self sendSynchronousRequest:request returningResponse:nil error:nil];
}
@end
