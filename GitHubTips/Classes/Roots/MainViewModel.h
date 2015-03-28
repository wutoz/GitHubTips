//
//  MainViewModel.h
//  HealthTip
//
//  Created by Yorke on 15/3/1.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "WTViewModel.h"

@class PersonViewModel;
@interface MainViewModel : WTViewModel

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, readonly) RACSubject *updatedContentSignal;

-(NSInteger)numberOfSections;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;
-(NSString *)titleForSection:(NSInteger)section;
-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
-(NSString *)subtitleAtIndexPath:(NSIndexPath *)indexPath;

- (PersonViewModel *)personViewModel:(NSIndexPath *)indexPath;

@end
