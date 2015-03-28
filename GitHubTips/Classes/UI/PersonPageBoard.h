//
//  PersonPageBoard.h
//  GitHubTips
//
//  Created by Yorke on 15/3/28.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "WTUIBoard.h"

@class PersonViewModel;
@interface PersonPageBoard : WTUIBoard

@property (nonatomic, strong) PersonViewModel *viewModel;

@end
