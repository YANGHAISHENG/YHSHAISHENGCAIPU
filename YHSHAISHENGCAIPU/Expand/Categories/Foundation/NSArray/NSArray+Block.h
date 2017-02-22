//
//  NSArray+Block.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Block)

- (void)enumerateObjects:(void (^)(id object))block;

- (void)enumerateObjectsWithIndex:(void (^)(id object, NSUInteger index))block;

- (NSArray *)filteredArray:(BOOL (^)(id object))block;

- (NSArray *)rejectedArray:(BOOL (^)(id object))block;

@end
