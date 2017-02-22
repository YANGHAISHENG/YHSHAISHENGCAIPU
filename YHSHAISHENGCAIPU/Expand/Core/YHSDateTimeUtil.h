//
//  YHSDateTimeUtil.h
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSDateTimeUtil : NSObject

#pragma mark 获取当前时间字符串
+ (NSString *)getCurrentTimeStamp;

#pragma mark 将指定格式时间字符串NSString转换成NSDate对象
+ (NSDate *)getDateTime:(NSString *)dataTimeString dataFormatter:(NSString *)dateFormatterString;

#pragma mark 将指定时间NSDate对象转换成指定格式时间字符串NSString
+ (NSString *)getDateString:(NSDate *)dataTime dataFormatter:(NSString *)dateFormatterString;

#pragma mark 转换时间字符串格式
+ (NSString *)getDateString:(NSString *)dataTimeString fromDataFormatter:(NSString *)fromDateFormatterString toDataFormatter:(NSString *)toDataFormatter;

@end
