//
//  PersonViewModel.m
//  GitHubTips
//
//  Created by Yorke on 15/3/28.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "PersonViewModel.h"
#import "WTUserUtils.h"
#import "CommonUtils.h"
#import "WTUser.h"
#import "WTEntity.h"

@interface PersonViewModel ()<NSFetchedResultsControllerDelegate>

@end

@implementation PersonViewModel

- (instancetype)initWithUser:(WTUser *)user {
    if(self = [super init]){
        _user = user;
        [WTUserUtils fetchUserInfoWithLogin:user.rawLogin];
        RAC(self, rawLogin) = RACObserve(self.user.wtentity, login);
        RAC(self, avatarURL) = RACObserve(self.user.wtentity,avatarURL);
        RAC(self, bio) = RACObserve(self.user.wtentity, bio);
        RAC(self, blog) = RACObserve(self.user.wtentity, blog);
        RAC(self, company) = RACObserve(self.user.wtentity, company);
        RAC(self, email) = RACObserve(self.user.wtentity, email);
        RAC(self, followers) = RACObserve(self.user.wtentity, followers);
        RAC(self, following) = RACObserve(self.user.wtentity, following);
        RAC(self, location) = RACObserve(self.user.wtentity, location);
        RAC(self, name) = RACObserve(self.user.wtentity, name);
    }
    return self;
}


@end
