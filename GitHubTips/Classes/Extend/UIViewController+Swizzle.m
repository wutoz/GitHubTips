//
//  UIViewController+Swizzle.m
//  HealthTip
//
//  Created by Yorke on 15/2/28.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "UIViewController+Swizzle.h"
#import "ObjcRuntime.h"

@implementation UIViewController (Swizzle)

- (void)WTViewDidLoad{
//    NSLog(@"%@ load",NSStringFromClass([self class]));
    
    [self WTViewDidLoad];
}

- (void)WTViewWillDisappear:(BOOL)animated{
//    NSLog(@"%@ disappear",NSStringFromClass([self class]));
    
    [self WTViewWillDisappear:animated];
}

- (void)WTViewWillAppear:(BOOL)animated{
//    NSLog(@"%@ appear",NSStringFromClass([self class]));
    
    [self WTViewWillAppear:animated];
}

void swizzleAllViewController(){
    Swizzle([UIViewController class], @selector(viewDidLoad), @selector(WTViewDidLoad));
    Swizzle([UIViewController class], @selector(viewWillDisappear:), @selector(WTViewWillDisappear:));
    Swizzle([UIViewController class], @selector(viewWillAppear:), @selector(WTViewWillAppear:));
}

@end
