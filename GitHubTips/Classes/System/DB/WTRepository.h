//
//  WTRepository.h
//  GitHubTips
//
//  Created by Yorke on 15/3/15.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WTEntity, WTObject, WTRepository;

@interface WTRepository : NSManagedObject

@property (nonatomic, retain) NSNumber * watchersCount;
@property (nonatomic, retain) NSNumber * subscribersCount;
@property (nonatomic, retain) NSNumber * stargazersCount;
@property (nonatomic, retain) NSString * sshURL;
@property (nonatomic, retain) NSString * repoDescription;
@property (nonatomic, retain) NSString * ownerLogin;
@property (nonatomic, retain) NSNumber * openIssuesCount;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * issuesHTMLURL;
@property (nonatomic, retain) NSNumber * isprivate;
@property (nonatomic, retain) NSString * httpsURL;
@property (nonatomic, retain) NSString * htmlURL;
@property (nonatomic, retain) NSString * gitURL;
@property (nonatomic, retain) NSNumber * fork;
@property (nonatomic, retain) NSNumber * focksCount;
@property (nonatomic, retain) NSString * defaultBranch;
@property (nonatomic, retain) NSDate * dateUpdated;
@property (nonatomic, retain) NSDate * datePushed;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) WTEntity *wtentity;
@property (nonatomic, retain) WTRepository *wtforkParent;
@property (nonatomic, retain) WTRepository *wtforkSource;
@property (nonatomic, retain) WTObject *wtobject;

@end
