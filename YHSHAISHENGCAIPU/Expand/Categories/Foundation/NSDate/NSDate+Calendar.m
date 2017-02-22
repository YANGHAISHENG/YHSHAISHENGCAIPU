//
//  NSDate+Calendar.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

+ (NSCalendar *)userCalendar
{
    return [[NSCalendar alloc] initWithCalendarIdentifier:[[NSCalendar currentCalendar] calendarIdentifier]];
}

+ (NSUInteger)fullCalendarComponents
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return (NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit);
#pragma clang diagnostic pop
}

+ (NSUInteger)dayCalendarComponents
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return (NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
#pragma clang diagnostic pop
}

+ (NSDate *)today
{
    return [NSDate todayByComponents:[NSDate fullCalendarComponents]];
}

+ (NSDate *)todayByComponents:(NSUInteger)comp
{
    NSCalendar *cal = [NSDate userCalendar];
    NSDateComponents *components = [cal components:comp fromDate:[NSDate date]];
    return [cal dateFromComponents:components];
}

+ (NSDate *)yesterday
{
    return [NSDate yesterdayByComponents:[NSDate fullCalendarComponents]];
}

+ (NSDate *)yesterdayByComponents:(NSUInteger)comp
{
    NSCalendar *cal = [NSDate userCalendar];
    NSDate *today = [NSDate today];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1];
    return [cal dateByAddingComponents:components toDate:today options:0];
}

- (NSInteger)weekdayUnit
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSDateComponents *weekdayComponents = [[NSDate userCalendar] components:NSWeekdayCalendarUnit fromDate:self];
    return [weekdayComponents weekday];
#pragma clang diagnostic pop
}

@end



