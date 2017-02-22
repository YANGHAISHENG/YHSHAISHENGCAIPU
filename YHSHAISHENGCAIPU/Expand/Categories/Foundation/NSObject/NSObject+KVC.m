//
//  NSObject+KVC.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "NSObject+KVC.h"
#import <objc/runtime.h>

@implementation NSObject (KVC)

- (NSArray *)allKeys
{
    NSMutableArray *keys = [NSMutableArray new];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([UITouch class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *key = [NSString stringWithFormat:@"%s %s\n", property_getName(property), property_getAttributes(property)];
        [keys addObject:key];
    }
    free(properties);
    
    return keys;
}

@end
