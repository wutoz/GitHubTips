//
//  WTPlan.h
//  GitHubTips
//
//  Created by Yorke on 15/3/15.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WTEntity, WTObject;

@interface WTPlan : NSManagedObject

@property (nonatomic, retain) NSNumber * space;
@property (nonatomic, retain) NSNumber * privateRepos;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * collaborators;
@property (nonatomic, retain) WTEntity *wtentity;
@property (nonatomic, retain) WTObject *wtobject;

@end
