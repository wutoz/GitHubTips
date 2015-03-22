//
//  WTUserUtils.h
//  GitHubTips
//
//  Created by Yorke on 15/3/20.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#pragma mark - 网络API

#import <Foundation/Foundation.h>

@interface WTUserUtils : NSObject

+ (void)fetchUserInfo;

+ (void)fetchFollowing;
+ (void)fetchFollowers;

@end
