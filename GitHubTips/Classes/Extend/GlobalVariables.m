//
//  GlobalVariables.m
//  HealthTip
//
//  Created by Yorke on 14/12/10.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables

+ (instancetype)locationManager{
    static GlobalVariables *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalVariables alloc]init];
    });
    return instance;
}

+ (BOOL)significantLocationChangeMonitoringAvailable{
    return [CLLocationManager significantLocationChangeMonitoringAvailable];
}

- (void)startUpdatingLocation{
    
}

- (void)stopUpdatingLocation{
    
}

- (void)startMonitorSignificantLocationChanges{
    
}

- (void)stopMonitorSignificantLocationChanges{
    
}

@end
