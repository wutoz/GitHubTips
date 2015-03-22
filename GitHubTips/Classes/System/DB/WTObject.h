//
//  WTObject.h
//  GitHubTips
//
//  Created by Yorke on 15/3/15.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WTEntity, WTPlan, WTRepository, WTServer;

@interface WTObject : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) WTEntity *wtentity;
@property (nonatomic, retain) WTPlan *wtplan;
@property (nonatomic, retain) WTRepository *wtrespository;
@property (nonatomic, retain) WTServer *wtserver;

@end
