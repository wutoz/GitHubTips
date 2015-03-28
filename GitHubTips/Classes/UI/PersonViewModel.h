//
//  PersonViewModel.h
//  GitHubTips
//
//  Created by Yorke on 15/3/28.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "WTViewModel.h"

@class WTUser;
@interface PersonViewModel : WTViewModel

- (instancetype)initWithUser:(WTUser *)user;

@property (nonatomic, strong) WTUser *user;

@property (nonatomic, copy) NSString *rawLogin;
@property (nonatomic, copy) NSURL * avatarURL;
@property (nonatomic, copy) NSString * bio;
@property (nonatomic, copy) NSString * blog;
@property (nonatomic, copy) NSString * company;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSNumber * followers;
@property (nonatomic, copy) NSNumber * following;
@property (nonatomic, copy) NSString * location;
@property (nonatomic, copy) NSString * name;

@end



