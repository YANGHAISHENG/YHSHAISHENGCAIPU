//
//  NSArray+SafeAccess.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "NSArray+SafeAccess.h"

@implementation NSArray (SafeAccess)

- (id)objectWithIndex:(NSUInteger)index {
    
    if (self.count > 0)
    {
        if (index < self.count) {
            return self[index];
        } else {
            return nil;
        }
    }
    else return nil;
}

- (NSString *)stringWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null] ||
        [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}

- (NSNumber *)numberWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        return [formatter numberFromString:(NSString *)value];
    }
    return nil;
}

- (NSDecimalNumber *)decimalNumberWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray *)arrayWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)dictionaryWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)integerWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] ||
        [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)unsignedIntegerWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] ||
        [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)boolWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)int16WithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)int32WithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] ||
        [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)int64WithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] ||
        [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)charWithIndex:(NSUInteger)index {
    
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] ||
        [value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    return 0;
}

- (short)shortWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (float)floatWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] ||
        [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (double)doubleWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] ||
        [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = dateFormat;
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] &&
        !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

// CG
- (CGFloat)CGFloatWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)pointFromStringWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)sizeFromStringWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)rectFromStringWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}

@end


#pragma-- mark NSMutableArray setter
@implementation NSMutableArray (SafeAccess)

- (void)addObj:(id)obj {
    if (obj != nil) {
        [self addObject:obj];
    }
}

- (void)addString:(NSString *)obj {
    if (obj != nil) {
        [self addObject:obj];
    }
}

- (void)addChar:(char)value {
    [self addObject:@(value)];
}

- (void)addBool:(BOOL)value {
    [self addObject:@(value)];
}

- (void)addInt:(int)value {
    [self addObject:@(value)];
}

- (void)addInteger:(NSInteger)value {
    [self addObject:@(value)];
}

- (void)addUnsignedInteger:(NSUInteger)value {
    [self addObject:@(value)];
}

- (void)addCGFloat:(CGFloat)value {
    [self addObject:@(value)];
}

- (void)addFloat:(float)value {
    [self addObject:@(value)];
}

- (void)addPointToString:(CGPoint)value {
    [self addObject:NSStringFromCGPoint(value)];
}

- (void)addSizeToString:(CGSize)value {
    [self addObject:NSStringFromCGSize(value)];
}

- (void)addRectToString:(CGRect)value {
    [self addObject:NSStringFromCGRect(value)];
}


@end




