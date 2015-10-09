//
//  DSXUserStatus.m
//  dsxcmsForIPhone
//
//  Created by songdewei on 15/8/25.
//  Copyright (c) 2015年 dsxcms. All rights reserved.
//
#import "Config.h"
#import "DSXUtil.h"
#import "DSXUserStatus.h"

@implementation DSXUserStatus
@synthesize isLogined;
@synthesize uid = _uid;
@synthesize username = _username;
@synthesize password = _password;
@synthesize email = _email;
@synthesize userpic = _userpic;
@synthesize avatar;
@synthesize signature;
@synthesize delegate;

- (instancetype)init{
    self = [super init];
    if (self) {
        [self reloadUserStatus];
    }
    return self;
}

- (void)reloadUserStatus{
    NSDictionary *userstatus = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userstatus"];
    NSString *username = [userstatus objectForKey:@"username"];
    NSInteger uid = [[userstatus objectForKey:@"uid"] intValue];
    if (uid>0 && username) {
        self.isLogined = YES;
        self.uid = uid;
        self.username = username;
        self.email = [userstatus objectForKey:@"email"];
        self.password = [userstatus objectForKey:@"password"];
        self.userpic  = [userstatus objectForKey:@"userpic"];
        self.avatar   = [UIImage imageWithData:[userstatus objectForKey:@"avatar"]];
        self.signature = [userstatus objectForKey:@"signature"];
    }else{
        self.isLogined = NO;
        self.uid = -1;
        self.username = nil;
        self.email = nil;
        self.password = nil;
        self.userpic = nil;
        self.avatar = nil;
        self.signature = nil;
    }
}

- (NSDictionary *)loginWithName:(NSString *)username andPassword:(NSString *)password{
    if (username && password) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:username forKey:@"username"];
        [params setObject:password forKey:@"password"];
        NSData *data = [[DSXUtil sharedUtil] sendDataForURL:[SITEAPI stringByAppendingString:@"&ac=login"] params:params];
        if (data) {
            id ucresult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //NSLog(@"%@",ucresult);
            if ([ucresult isKindOfClass:[NSDictionary class]]) {
                NSMutableDictionary *userstatus = [NSMutableDictionary dictionaryWithDictionary:ucresult];
                NSData *avatarData = [[DSXUtil sharedUtil] dataWithURL:[userstatus objectForKey:@"userpic"]];
                if (avatarData != nil) {
                    [userstatus setObject:avatarData forKey:@"avatar"];
                }
                [[NSUserDefaults standardUserDefaults] setObject:userstatus forKey:@"userstatus"];
                [self reloadUserStatus];
                [[NSNotificationCenter defaultCenter] postNotificationName:UserStatusChangedNotification object:nil userInfo:@{@"userstatus":self}];
                [delegate afterLogin];
                return userstatus;
            }else {
                return nil;
            }
            
        }else{
            return nil;
        }
    }else {
        return nil;
    }
}

- (void)logout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userstatus"];
    [self reloadUserStatus];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserStatusChangedNotification object:nil userInfo:@{@"userstatus":self}];
    [delegate afterLogout];
}

- (NSDictionary *)registerWithData:(NSMutableDictionary *)params{
    NSData *data = [[DSXUtil sharedUtil] sendDataForURL:[SITEAPI stringByAppendingString:@"&ac=register"] params:params];
    id dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return dictionary;
    }else {
        return nil;
    }
}

@end
NSString *const UserStatusChangedNotification = @"UserStatusChangedNotification";