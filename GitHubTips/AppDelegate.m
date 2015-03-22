//
//  AppDelegate.m
//  HealthTip
//
//  Created by Yorke on 14/11/30.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "AppDelegate.h"

#import "WTNavigationBoard.h"

#import "MainBoard.h"
#import "LeftBoard.h"
#import "RightBoard.h"
#import "WTDrawerVisualStateManager.h"
#import "GlobalVariables.h"

#import "CommonUtils.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    MainBoard *board = [[MainBoard alloc]init];
//    
    self.window.rootViewController = self.drawerController;
    
    [CommonUtils startOCTClientServer];
    
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (MMDrawerController *)drawerController{
    if(!_drawerController){
        UIViewController *leftBoard = [[LeftBoard alloc]init];
        UIViewController *mainBoard = [[MainBoard alloc]init];
        UIViewController *rightBoard = [[RightBoard alloc]init];
        UINavigationController *mainNav = [[WTNavigationBoard alloc]initWithRootViewController:mainBoard];
        [mainNav setRestorationIdentifier:@"mainBoardKey"];
        UINavigationController *leftNav = [[WTNavigationBoard alloc]initWithRootViewController:leftBoard];
        [leftBoard setRestorationIdentifier:@"leftBoardKey"];
        UINavigationController *rightNav = [[WTNavigationBoard alloc]initWithRootViewController:rightBoard];
        [rightBoard setRestorationIdentifier:@"rightBoardKey"];
        _drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:mainNav
                             leftDrawerViewController:leftNav
                             rightDrawerViewController:rightNav];
        [_drawerController setShowsShadow:NO];
        [_drawerController setRestorationIdentifier:@"boardKey"];
        [_drawerController setMaximumRightDrawerWidth:200.0f];
        [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [_drawerController setRightDrawerViewController:nil];
        [_drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
            MMDrawerControllerDrawerVisualStateBlock block;
            block = [[WTDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
            if(block){
                block(drawerController,drawerSide,percentVisible);
            }
            
        }];
    }
    
    return _drawerController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    if([GlobalVariables significantLocationChangeMonitoringAvailable]){
        [[GlobalVariables locationManager] stopUpdatingLocation];
        [[GlobalVariables locationManager] startMonitorSignificantLocationChanges];
    }else{
        NSLog(@"Significant location change monitoring is not available.");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if([GlobalVariables significantLocationChangeMonitoringAvailable]){
        [[GlobalVariables locationManager] stopMonitorSignificantLocationChanges];
        [[GlobalVariables locationManager] startUpdatingLocation];
    }else{
        NSLog(@"Significant location change monitoring is not available.");
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // For handling a callback URL like my-app://oauth
    if ([URL.host isEqual:@"oauth"]) {
        [OCTClient completeSignInWithCallbackURL:URL];
        return YES;
    } else {
        return NO;
    }
}


@end
