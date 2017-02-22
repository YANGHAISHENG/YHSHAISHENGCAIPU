//
//  NSArray+Query.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "NSArray+Query.h"

@implementation NSArray (Query)


- (NSUInteger)lastObjectIndex
{
    return [self indexOfObject:[self lastObject]];
}


- (NSArray *)reversedArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    
    for (id element in enumerator) [array addObject:element];
    
    return array;
}

@end
