//
//  YHSSystemUtil.h
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSSystemUtil : NSObject


#pragma mark 保存Cookie（登录成功或注册成功）
+ (void)saveUserCookie:(NSURLSessionDataTask *)task;
#pragma mark 获取本地用户Cookie
+ (NSString *)getUserCookie;
#pragma mark 设置本地用户Cookie（退出登录）
+ (NSString *)setUserCookieForExit;


#pragma mark -
#pragma mark 验证字符串是否为空
+ (BOOL)validateEmpty:(NSString *)value;


#pragma mark -
#pragma mark 获取字符串的宽度
+ (CGRect)getStringWidth:(NSString *)value font:(UIFont *)font width:(CGFloat)width;
#pragma mark 删除字符串两端的空格与回车
+ (NSString *)stringByTrimmingWhitespaceAndNewline:(NSString *)value;
#pragma mark 对空白字符串进行处理
+ (NSString *)getStringWithNoWhitespaceAndNewline:(NSString *)value;
#pragma mark 验证字典是否为空
+ (BOOL)validateDictionaryIsNull:(id)dict;
#pragma mark 验证对象是否为空（数组、字典、字符串）
+ (BOOL)validateObjectIsNull:(id)obj;
#pragma mark 处理字典中的空值与NSNull
+ (id) dictionaryTrimmingNSNull:(id)obj;



@end
