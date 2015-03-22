//
//  CommonUtils.h
//  GitHubTips
//
//  Created by Yorke on 15/3/14.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#pragma mark - 登录&客户端

#import <Foundation/Foundation.h>
#import "OctoKit.h"

@interface CommonUtils : NSObject

//初始化客户端服务
+ (void)startOCTClientServer;

//首次登录验证
+ (void)signInToServerUsingWebBrowserCompletion:(dispatch_block_t)completion failure:(dispatch_block_t)failure;

//current ’user‘
+ (OCTClient *)client;

//OCTUser(unauthenticated) related
+ (OCTClient *)clientWithUser:(OCTUser *)user;

//Login(unauthenticated) everyone
+ (OCTClient *)clientWithLogin:(NSString *)login;

@end
