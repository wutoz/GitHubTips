//
//  WTCoreDataStack.h
//  HealthTip
//
//  Created by Yorke on 15/3/1.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#pragma mark - 数据库

#import <Foundation/Foundation.h>

@class OCTUser;
@interface WTCoreDataStack : NSObject

+ (instancetype)defaultStack;
+ (instancetype)inMemoryStack;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readonly) dispatch_queue_t coredataQueue;

+ (void)saveOCTUsers:(NSArray *)currentUsers;
+ (void)deleteOCTUsers:(NSArray *)currentUsers;
+ (OCTUser *)selectOCTUser:(NSString *)login;

- (void)saveContext;
- (void)ensureInitialLoad;

@end
