//
//  NSDate+Comparison.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Useful methods for comparing dates.
*/
@interface NSDate (Comparison)

- (BOOL)isToday;

- (BOOL)isYesterday;

- (BOOL)isFirstDayOfMonth;

- (BOOL)hasSameUnit:(unsigned)unitFlags thanDate:(NSDate *)date;

@end
