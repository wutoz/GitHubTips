//
//  WTEntity.h
//  GitHubTips
//
//  Created by Yorke on 15/3/15.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WTObject, WTPlan, WTRepository, WTUser;

@interface WTEntity : NSManagedObject

@property (nonatomic, retain) NSString * avatarURL;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * blog;
@property (nonatomic, retain) NSNumber * collaborators;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSNumber * diskUsage;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * followers;
@property (nonatomic, retain) NSNumber * following;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * privateGistCount;
@property (nonatomic, retain) NSNumber * privateRepoCount;
@property (nonatomic, retain) NSNumber * publicGistCount;
@property (nonatomic, retain) NSNumber * publicRepoCount;
@property (nonatomic, retain) WTObject *wtobject;
@property (nonatomic, retain) WTPlan *wtplan;
@property (nonatomic, retain) NSSet *wtrepositories;
@property (nonatomic, retain) WTUser *wtuser;
@end

@interface WTEntity (CoreDataGeneratedAccessors)

- (void)addWtrepositoriesObject:(WTRepository *)value;
- (void)removeWtrepositoriesObject:(WTRepository *)value;
- (void)addWtrepositories:(NSSet *)values;
- (void)removeWtrepositories:(NSSet *)values;

@end
