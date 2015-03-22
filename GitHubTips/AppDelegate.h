//
//  AppDelegate.h
//  HealthTip
//
//  Created by Yorke on 14/11/30.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController/MMDrawerController.h>

#define APPDELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MMDrawerController *drawerController;



@end

