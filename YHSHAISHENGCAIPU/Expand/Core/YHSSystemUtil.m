//
//  YHSSystemUtil.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "YHSSystemUtil.h"

@implementation YHSSystemUtil


#pragma mark -
#pragma mark 保存Cookie（登录成功或注册成功）
+ (void)saveUserCookie:(NSURLSessionDataTask *)task
{
    // 获取Cookie值
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSString *cookieValue = response.allHeaderFields[@"Set-Cookie"];
    
    YHSDEBUGLog(@"%@", cookieValue);
    
    // 保存Cookie值到本地
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:cookieValue forKey:NETWORK_USER_COOKIE_KEY];
    
    // 持久化数据
    [userDefaults synchronize];
}


#pragma mark 获取本地用户Cookie
+ (NSString *)getUserCookie
{
    // 保存Cookie值到本地
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *cookieValue = [userDefaults objectForKey:NETWORK_USER_COOKIE_KEY];
    return cookieValue;
}


#pragma mark 设置本地用户Cookie（退出登录）
+ (NSString *)setUserCookieForExit
{
    // 保存Cookie值到本地
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:NETWORK_USER_COOKIE_VALUE forKey:NETWORK_USER_COOKIE_KEY];
    // 持久化数据
    [userDefaults synchronize];
    
    return NETWORK_USER_COOKIE_VALUE;
}



#pragma mark -
#pragma mark 验证字符串是否为空
+ (BOOL)validateEmpty:(NSString *)value
{
    if (nil == value || [@"NULL" isEqualToString:value] || [value isEqualToString:@"<null>"]) {
        return YES;
    }
    
    // 删除两端的空格和回车
    NSString *str = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (str.length <= 0);
}


#pragma mark -
#pragma mark 获取字符串的宽度
+ (CGRect)getStringWidth:(NSString *)value font:(UIFont *)font width:(CGFloat)width
{
    // 根据文字字数动态确定控件宽高，此方法只生成单个文本行的高度。
    // CGSize textSize = [value sizeWithAttributes:@{ NSFontAttributeName:font }];
    
    // 根据正文内容多少，动态确定正文 content 的 frame 值
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                   attributes:attributes
                                      context:nil];
    
    return rect;
}


#pragma mark 删除字符串两端的空格与回车
+ (NSString *)stringByTrimmingWhitespaceAndNewline:(NSString *)value
{
    if ([YHSSystemUtil validateObjectIsNull:value]) {
        return @"";
    }
    
    return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


#pragma mark 对空白字符串进行处理
+ (NSString *)getStringWithNoWhitespaceAndNewline:(NSString *)value
{
    NSString *contentString = [YHSSystemUtil stringByTrimmingWhitespaceAndNewline:value];
    return (nil == contentString || contentString.length == 0) ? STR_WHITE_SPACE : contentString;
}



#pragma mark 验证字典是否为空
+ (BOOL)validateDictionaryIsNull:(id)dict
{
    // 字典
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        if([dict isKindOfClass:[NSNull class]]) {
            return YES;
        }
    }
    // 字符串
    else if ([dict isKindOfClass:[NSString class]]) {
        
        return [YHSSystemUtil validateEmpty:dict];
    }
    
    return NO;
}


#pragma mark 验证对象是否为空（数组、字典、字符串）
+ (BOOL)validateObjectIsNull:(id)obj
{
    if (nil == obj) {
        return YES;
    }
    
    // 字典
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
        if([obj isKindOfClass:[NSNull class]]) {
            return YES;
        }
    }
    // 数组
    else if ([obj isKindOfClass:[NSArray class]]) {
        
        if([obj isKindOfClass:[NSNull class]]) {
            return YES;
        }
    }
    // 字符串
    else if ([obj isKindOfClass:[NSString class]]) {
        
        return [YHSSystemUtil validateEmpty:obj];
    }
    
    return NO;
}


#pragma mark 处理字典中的空值与NSNull
+ (id) dictionaryTrimmingNSNull:(id)obj
{
    const NSString *blank = @"";
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dict = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dict allKeys]) {
            id object = [dict objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dict setObject:blank forKey:key];
            } else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    [dict setObject:blank forKey:key];
                }
            } else if ([object isKindOfClass:[NSArray class]]){
                NSArray *array = (NSArray*)object;
                array = [YHSSystemUtil dictionaryTrimmingNSNull:array];
                [dict setObject:array forKey:key];
            } else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [YHSSystemUtil dictionaryTrimmingNSNull:object];
                [dict setObject:ddc forKey:key];
            }
        }
        return [dict copy];
    } else if ([obj isKindOfClass:[NSArray class]]) {
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [YHSSystemUtil dictionaryTrimmingNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    } else{
        return obj;
    }
}




@end
