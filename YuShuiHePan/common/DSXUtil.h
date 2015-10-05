//
//  DSXUtil.h
//  YuShuiHePan
//
//  Created by songdewei on 15/10/5.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSXUtil : NSObject

+ (instancetype)sharedUtil;

- (NSData *)dataWithURL:(NSString *)urlString;
- (NSData *)sendDataForURL:(NSString *)urlString params:(NSMutableDictionary *)params;

@end
