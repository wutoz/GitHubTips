//
//  WTUser.h
//  GitHubTips
//
//  Created by Yorke on 15/3/15.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WTEntity;

@interface WTUser : NSManagedObject

@property (nonatomic, retain) NSString * rawLogin;
@property (nonatomic, retain) WTEntity *wtentity;

@end
