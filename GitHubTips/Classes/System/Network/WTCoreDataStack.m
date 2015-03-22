//
//  WTCoreDataStack.m
//  HealthTip
//
//  Created by Yorke on 15/3/1.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "WTCoreDataStack.h"
#import "CommonUtils.h"
#import "WTUser.h"
#import "WTEntity.h"
#import "WTObject.h"
#import "WTServer.h"
#import "WTPlan.h"
#import "WTRepository.h"

@interface WTCoreDataStack ()

@property (readwrite, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readwrite, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation WTCoreDataStack

+ (instancetype)defaultStack{
    static WTCoreDataStack *stack;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [[self alloc]init];
    });
    return stack;
}

+ (instancetype)inMemoryStack{
    static WTCoreDataStack *stack;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [[self alloc]init];
        
        NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[stack managedObjectModel]];
        NSError *error;
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
        stack.persistentStoreCoordinator = persistentStoreCoordinator;
    });
    return stack;
}

- (instancetype)init{
    if(self = [super init]){
        _coredataQueue = dispatch_queue_create("com.wt.coredata", NULL);
    }
    return self;
}

- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }

}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext!= nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GitHubTips" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GitHubTips.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)ensureInitialLoad{
    NSString *initialLoadKey = @"Initial Load";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL hasInitialLoad = [userDefaults boolForKey:initialLoadKey];
    if(hasInitialLoad == NO){
        [userDefaults setBool:YES forKey:initialLoadKey];
        {
            RACSignal *request = [[CommonUtils client] fetchUserInfo];
            [request subscribeNext:^(OCTUser *user) {
                [WTCoreDataStack saveOCTUsers:@[user]];
            } error:^(NSError *error) {
                NSLog(@"%ld",[error code]);
            } completed:^{
                NSLog(@"completed");
            }];
        }
    }
}

+ (void)saveOCTUsers:(NSArray *)currentUsers{
    //判断数据库中是否存在，存在则修改，不存在则新增
    for(OCTUser *user in currentUsers){
        [[WTCoreDataStack defaultStack] saveOCTUser:user];
    }
}

+ (void)deleteOCTUsers:(NSArray *)currentUsers{
    for(OCTUser *user in currentUsers){
        
    }
}

+ (OCTUser *)selectOCTUser:(NSString *)login{
    return nil;
}

- (void)saveOCTUser:(OCTUser *)currentUser{
    dispatch_async(_coredataQueue, ^{
        WTUser *user = [NSEntityDescription insertNewObjectForEntityForName:@"WTUser" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
        user.rawLogin = currentUser.login;
        
        user.wtentity = ({
            WTEntity *entity = [NSEntityDescription insertNewObjectForEntityForName:@"WTEntity" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            entity.wtuser = user;
            entity.avatarURL = [currentUser.avatarURL absoluteString];
            entity.bio = currentUser.bio;
            entity.blog = currentUser.blog;
            entity.collaborators = @(currentUser.collaborators);
            entity.company = currentUser.company;
            entity.diskUsage = @(currentUser.diskUsage);
            entity.email = currentUser.email;
            entity.followers = @(currentUser.followers);
            entity.following = @(currentUser.following);
            entity.location = currentUser.location;
            entity.login = currentUser.login;
            entity.name = currentUser.name;
            
            entity.wtobject = ({
                WTObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"WTObject" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
                object.wtentity = entity;
                object.uid = currentUser.objectID;
                
                object.wtserver = ({
                    WTServer *objectServer = [NSEntityDescription insertNewObjectForEntityForName:@"WTServer" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
                    objectServer.wtobject = object;
                    objectServer.baseURL = [currentUser.server.baseURL absoluteString];
                    objectServer;
                });
                
                object;
            });
            
            entity.wtplan = ({
                WTPlan *plan = [NSEntityDescription insertNewObjectForEntityForName:@"WTPlan" inManagedObjectContext:[[WTCoreDataStack defaultStack]managedObjectContext]];
                plan.wtentity = entity;
                plan.collaborators = @(currentUser.plan.collaborators);
                plan.name = currentUser.plan.name;
                plan.privateRepos = @(currentUser.plan.privateRepos);
                plan.space = @(currentUser.plan.space);
                
                plan.wtobject = ({
                    WTObject *planObject = [NSEntityDescription insertNewObjectForEntityForName:@"WTObject" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
                    planObject.wtplan = plan;
                    planObject.uid = currentUser.plan.objectID;
                    planObject.wtserver = ({
                        WTServer *planObjectServer = [NSEntityDescription insertNewObjectForEntityForName:@"WTServer" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
                        planObjectServer.wtobject = planObject;
                        planObjectServer.baseURL = [currentUser.plan.server.baseURL absoluteString];
                        planObjectServer;
                    });
                    
                    planObject;
                });
                
                plan;
            });
            
            entity.privateGistCount = @(currentUser.privateGistCount);
            entity.privateRepoCount = @(currentUser.privateRepoCount);
            entity.publicGistCount = @(currentUser.publicGistCount);
            entity.publicRepoCount = @(currentUser.publicRepoCount);
            
            entity.wtrepositories = [NSSet set];
            entity;
        });
        
        [[WTCoreDataStack defaultStack]saveContext];
    });
    
}


@end
