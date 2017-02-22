//
//  NSDate+Calendar.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

+ (NSCalendar *)userCalendar;

+ (NSUInteger)fullCalendarComponents;
+ (NSUInteger)dayCalendarComponents;

+ (NSDate *)today;
+ (NSDate *)todayByComponents:(NSUInteger)comp;

+ (NSDate *)yesterday;
+ (NSDate *)yesterdayByComponents:(NSUInteger)comp;

- (NSInteger)weekdayUnit;

@end
