//
//  WTServer.h
//  GitHubTips
//
//  Created by Yorke on 15/3/15.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WTObject;

@interface WTServer : NSManagedObject

@property (nonatomic, retain) NSNumber * enterprise;
@property (nonatomic, retain) NSString * baseWebURL;
@property (nonatomic, retain) NSString * baseURL;
@property (nonatomic, retain) NSString * aPIEndpoint;
@property (nonatomic, retain) WTObject *wtobject;

@end
