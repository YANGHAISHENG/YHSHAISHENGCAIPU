//
//  NSArray+Query.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Useful methods to ease NSArray queries.
 */
@interface NSArray (Query)

/*
 Returns the lastest object's index in the array.
 
 @returns The last object's index in the array.
*/
- (NSUInteger)lastObjectIndex;


/*
 Returns a reversed array.
 
 @returns A reversed array.
*/
- (NSArray *)reversedArray;

@end
