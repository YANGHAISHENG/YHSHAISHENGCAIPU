//
//  NSMutableDictionary+Safe.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

- (id)safeObjectForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSNull class]] || !object) return nil;
    else return object;
}

- (void)setSafeObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (!anObject) [self setObject:[NSNull new] forKey:aKey];
    else [self setObject:anObject forKey:aKey];
}

@end
