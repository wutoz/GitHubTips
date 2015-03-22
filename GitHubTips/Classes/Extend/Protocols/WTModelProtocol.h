//
//  WTModelProtocol.h
//  HealthTip
//
//  Created by Yorke on 15/3/1.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTModelProtocol <NSObject>

- (void)addData:(id)match;

- (void)deleteData:(id)match;

- (void)modifyData:(id)origMatch with:(id)newMatch;

- (BOOL)selectData:(id)match;

@end
