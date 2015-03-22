//
//  MainViewModel.m
//  HealthTip
//
//  Created by Yorke on 15/3/1.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "MainViewModel.h"
#import "CommonUtils.h"
#import "WTUser.h"
#import "WTEntity.h"

@interface MainViewModel ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) RACSubject *updatedContentSignal;

@end

@implementation MainViewModel

- (instancetype)init{
    if(self = [super init]){
        self.updatedContentSignal = [[RACSubject subject]setNameWithFormat:@"MainViewModelupdatedContentSignal"];
        
        @weakify(self);
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            [self.fetchedResultsController performFetch:nil];
        }];
    }
    return self;
}

-(NSInteger)numberOfSections{
    return [[self.fetchedResultsController sections]count];
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

-(NSString *)titleForSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    NSArray *sectionObjects = [sectionInfo objects];
    WTUser *representativeObject = [sectionObjects firstObject];

    return representativeObject.wtentity.company;
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath{
    WTUser *user = [self userAtIndexPath:indexPath];
    return [user valueForKey:@keypath(user,rawLogin)];
}

-(NSString *)subtitleAtIndexPath:(NSIndexPath *)indexPath{
    WTUser *user = [self userAtIndexPath:indexPath];
    return [user valueForKey:@keypath(user,rawLogin)];
}

-(WTUser *)userAtIndexPath:(NSIndexPath *)indexPath{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSFetchedResultsController *)fetchedResultsController{
    if(!_fetchedResultsController){
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"WTUser" inManagedObjectContext:[WTCoreDataStack defaultStack].managedObjectContext];
        [fetchRequest setEntity:entity];
        // Specify criteria for filtering which objects to fetch
//        NSNumber *uid = @10;
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid < %d", uid];
//        [fetchRequest setPredicate:predicate];
        // Specify how the fetched objects should be sorted
//        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"uid"
//                                                                       ascending:YES];
        [fetchRequest setSortDescriptors:
         [NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"rawLogin" ascending:YES],nil]];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[WTCoreDataStack defaultStack].managedObjectContext sectionNameKeyPath:@"rawLogin" cacheName:@"Master"];
        
        _fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        if (![_fetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
    }
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [(RACSubject *)self.updatedContentSignal sendNext:nil];
}

@end
