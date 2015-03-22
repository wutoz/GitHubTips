//
//  WTDrawerVisualStateManager.h
//  HealthTip
//
//  Created by Yorke on 15/2/28.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MMDrawerController/MMDrawerVisualState.h>

typedef NS_ENUM(NSInteger, MMDrawerAnimationType){
    MMDrawerAnimationTypeNone,
    MMDrawerAnimationTypeSlide,
    MMDrawerAnimationTypeSlideAndScale,
    MMDrawerAnimationTypeSwingingDoor,
    MMDrawerAnimationTypeParallax,
};

@interface WTDrawerVisualStateManager : NSObject

@property (nonatomic,assign) MMDrawerAnimationType leftDrawerAnimationType;
@property (nonatomic,assign) MMDrawerAnimationType rightDrawerAnimationType;

+ (instancetype)sharedManager;

-(MMDrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(MMDrawerSide)drawerSide;

@end
