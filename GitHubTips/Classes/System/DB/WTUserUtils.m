//
//  WTUserUtils.m
//  GitHubTips
//
//  Created by Yorke on 15/3/20.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "WTUserUtils.h"
#import "CommonUtils.h"

@implementation WTUserUtils

+ (void)fetchFollowing {
    RACSignal *request = [[CommonUtils client] fetchFollowing];
    [[request collect] subscribeNext:^(NSArray *followings) {
        [WTCoreDataStack saveOCTUsers:followings];
    } error:^(NSError *error) {
        NSLog(@"%ld",[error code]);
    } completed:^{
        NSLog(@"completed");
    }];
}

+ (void)fetchFollowers {
    RACSignal *request = [[CommonUtils client] fetchFollowers];
    [[request collect] subscribeNext:^(NSArray *followers) {
        [WTCoreDataStack saveOCTUsers:followers];
    } error:^(NSError *error) {
        NSLog(@"%ld",[error code]);
    } completed:^{
        NSLog(@"completed");
    }];
}

+ (void)fetchUserInfo {
    RACSignal *request = [[CommonUtils client] fetchUserInfo];
    [request subscribeNext:^(OCTUser *user) {
        NSLog(@"%@",user.company);
    } error:^(NSError *error) {
        NSLog(@"%ld",[error code]);
    } completed:^{
        NSLog(@"completed");
    }];
}

+ (void)fetchUserInfoWithUser:(OCTUser *)user {
    RACSignal *request = [[CommonUtils clientWithUser:user] fetchUserInfo];
    [request subscribeNext:^(OCTUser *user) {
        
    } error:^(NSError *error) {
        NSLog(@"%ld",[error code]);
    } completed:^{
        NSLog(@"completed");
    }];
}

+ (void)fetchUserInfoWithLogin:(NSString *)login {
    RACSignal *request = [[CommonUtils clientWithLogin:login] fetchUserInfo];
    [request subscribeNext:^(OCTUser *user) {
        
    } error:^(NSError *error) {
        NSLog(@"%ld",[error code]);
    } completed:^{
        NSLog(@"completed");
    }];
}

@end
