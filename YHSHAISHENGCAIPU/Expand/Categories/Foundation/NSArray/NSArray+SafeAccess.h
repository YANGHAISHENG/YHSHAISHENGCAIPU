//
//  NSArray+SafeAccess.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeAccess)

- (id)objectWithIndex:(NSUInteger)index;

- (NSString*)stringWithIndex:(NSUInteger)index;

- (NSNumber*)numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)integerWithIndex:(NSUInteger)index;

- (NSUInteger)unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)boolWithIndex:(NSUInteger)index;

- (int16_t)int16WithIndex:(NSUInteger)index;

- (int32_t)int32WithIndex:(NSUInteger)index;

- (int64_t)int64WithIndex:(NSUInteger)index;

- (char)charWithIndex:(NSUInteger)index;

- (short)shortWithIndex:(NSUInteger)index;

- (float)floatWithIndex:(NSUInteger)index;

- (double)doubleWithIndex:(NSUInteger)index;

- (NSDate *)dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;

// CG
- (CGFloat)CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)pointFromStringWithIndex:(NSUInteger)index;

- (CGSize)sizeFromStringWithIndex:(NSUInteger)index;

- (CGRect)rectFromStringWithIndex:(NSUInteger)index;
@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(SafeAccess)

- (void)addObj:(id)obj;

- (void)addString:(NSString *)obj;

- (void)addChar:(char)value;

- (void)addBool:(BOOL)value;

- (void)addInt:(int)value;

- (void)addInteger:(NSInteger)value;

- (void)addUnsignedInteger:(NSUInteger)value;

- (void)addCGFloat:(CGFloat)value;

- (void)addFloat:(float)value;

- (void)addPointToString:(CGPoint)value;

- (void)addSizeToString:(CGSize)value;

- (void)addRectToString:(CGRect)value;

@end


