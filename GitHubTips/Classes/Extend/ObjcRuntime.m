//
//  ObjcRuntime.m
//  HealthTip
//
//  Created by Yorke on 15/2/28.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "ObjcRuntime.h"
#import <objc/runtime.h>

NSDictionary *GetPropertyListOfObject(NSObject *object){
    return GetPropertyListOfClass([object class]);
}

NSDictionary *GetPropertyListOfClass(Class cls){
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for(i = 0; i < outCount; i++){
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        const char *propType = property_getAttributes(property);
        if(propType && propName){
            NSArray *anAttribute = [[NSString stringWithUTF8String:propType]componentsSeparatedByString:@","];
            NSString *aType = anAttribute[0];
            
            [dict setObject:aType forKey:[NSString stringWithUTF8String:propName]];
        }
    }
    free(properties);
    
    return dict;
}

void Swizzle(Class c, SEL origSEL, SEL newSEL){
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if(!origMethod){
        origMethod = class_getClassMethod(c, origSEL);
        if(!origMethod) return;
        
        newMethod = class_getClassMethod(c, newSEL);
        if(!newMethod) return;
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
        if(!newMethod) return;
    }
    
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
    }
}
