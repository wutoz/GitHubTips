//
//  WTCircleLayer.m
//  HealthTip
//
//  Created by Yorke on 14/12/8.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "WTCircleLayer.h"

#define r 20.0f

@implementation WTCircleLayer


-(void)drawInContext:(CGContextRef)ctx{
    CGRect rect = self.bounds;
    
    CGContextAddEllipseInRect(ctx, CGRectMake(rect.origin.x + rect.size.width / 2 - r, rect.origin.y + rect.size.height / 2, 2 * r, 2 * r));
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 0.6);//blue
    CGContextFillPath(ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(rect.origin.x + rect.size.width / 2 - r + sqrt(3) * r / 2, rect.origin.y + rect.size.height / 2 - 3 * r / 2, 2 * r, 2 * r));
    CGContextSetRGBFillColor(ctx, 0, 1, 0, 0.6);//green
    CGContextFillPath(ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(rect.origin.x + rect.size.width / 2 - r - sqrt(3) * r / 2, rect.origin.y + rect.size.height / 2 - 3 * r / 2, 2 * r, 2 * r));
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 0.6);//red
    CGContextFillPath(ctx);
    
}

-(instancetype)init{
    if(self = [super init]){
        self.bounds=CGRectMake(0, 0, 5 * r, 5 * r);
        
        [self addAnimation];
    }
    return self;
}

-(void)storeValue{
    NSLog(@"%f",self.frame.origin.y);
}

-(void)addAnimation{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = @0;
    shake.toValue = @(2 * M_PI);
    shake.repeatCount = INT64_MAX;
    shake.duration = 5;

    shake.removedOnCompletion = NO;
    shake.fillMode = kCAFillModeBoth;
    shake.autoreverses = NO;
    [self addAnimation:shake forKey:@"shakeAnimation"];
}
@end
