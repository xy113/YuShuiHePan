//
//  DSXURLConnection.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSXURLConnection : NSURLConnection

+ (NSData *)dataWithURL:(NSString *)urlString;

@end
