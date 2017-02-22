//
//  NSDate+Comparison.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "NSDate+Comparison.h"
#import "NSDate+Converter.h"
#import "NSDate+Calendar.h"

@implementation NSDate (Comparison)

- (BOOL)isToday
{
    NSCalendar *cal = [NSDate userCalendar];
    NSDate *today = [NSDate today];
    
    NSDateComponents *components = [cal components:[NSDate fullCalendarComponents] fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];

    return ([today compare:otherDate] == NSOrderedSame);
}

- (BOOL)isYesterday
{
    NSCalendar *cal = [NSDate userCalendar];
    NSDate *yesterday = [NSDate yesterday];
    
    NSDateComponents *components = [cal components:[NSDate fullCalendarComponents] fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    return ([yesterday compare:otherDate] == NSOrderedSame);
}

- (BOOL)isFirstDayOfMonth
{
    NSCalendar *cal = [NSDate userCalendar];
    
    NSDateComponents *components = [cal components:[NSDate fullCalendarComponents] fromDate:self];
    [components setDay:1];
    NSDate *firstDayOfMonthDate = [cal dateFromComponents:components];
    
    components = [cal components:[NSDate fullCalendarComponents] fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    return ([firstDayOfMonthDate compare:otherDate] == NSOrderedSame);
}

- (BOOL)hasSameUnit:(unsigned)unitFlags thanDate:(NSDate *)date
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (unitFlags == NSMinuteCalendarUnit) {
        NSString *selfMinute = [self stringFromDateWithFormat:kNSDateFormatShortTime];
        NSString *comparingMinute = [date stringFromDateWithFormat:kNSDateFormatShortTime];
        if ([selfMinute isEqualToString:comparingMinute]) return YES;
    }
    return NO;
#pragma clang diagnostic pop
}

@end




