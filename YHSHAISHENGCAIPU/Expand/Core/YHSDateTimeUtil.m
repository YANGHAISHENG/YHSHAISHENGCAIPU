//
//  YHSDateTimeUtil.m
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSDateTimeUtil.h"
#import "NSDateFormatter+Make.h"


@implementation YHSDateTimeUtil


#pragma mark 获取当前时间字符串
+ (NSString *)getCurrentTimeStamp
{
    return [YHSDateTimeUtil getDateString:nil dataFormatter:@"YYYY-MM-dd hh:mm:ss"];
}


#pragma mark 将指定格式时间字符串NSString转换成NSDate对象
+ (NSDate *)getDateTime:(NSString *)dataTimeString dataFormatter:(NSString *)dateFormatterString
{
    // 如果时间为空，则返回nil
    if (nil == dataTimeString) {
        return nil;
    }
    
    // 转换字符串为时间
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:dateFormatterString];
    NSDate *dataTime = [dateFormatter dateFromString:dataTimeString];
    return dataTime;
}


#pragma mark 将指定时间NSDate对象转换成指定格式时间字符串NSString
+ (NSString *)getDateString:(NSDate *)dataTime dataFormatter:(NSString *)dateFormatterString
{
    // 如果时间为空，则返回当前时间
    if (nil == dataTime) {
        dataTime = [NSDate date];
    }
    
    // 转换时间为字符串
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:dateFormatterString];
    NSString *dateString = [dateFormatter stringFromDate:dataTime];
    return dateString;
}


#pragma mark 转换时间字符串格式
+ (NSString *)getDateString:(NSString *)dataTimeString fromDataFormatter:(NSString *)fromDateFormatterString toDataFormatter:(NSString *)toDataFormatter
{
    // 将指定格式时间字符串NSString转换成NSDate对象
    NSDate *dataTime = [YHSDateTimeUtil getDateTime:dataTimeString dataFormatter:fromDateFormatterString];
    // 将指定时间NSDate对象转换成指定格式时间字符串NSString
    NSString *dataString = [YHSDateTimeUtil getDateString:dataTime dataFormatter:toDataFormatter];

    return dataString;
}


@end



