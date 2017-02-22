//
//  YHSSysLogMacro.h
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#ifndef YHSSysLogMacro_h
#define YHSSysLogMacro_h


// 控制台打印 - Xcode8
#ifdef DEBUG
#define YHSLog(format, ...) printf("[%s] %s [第%d行] => %s \n", [[YHSDateTimeUtil getCurrentTimeStamp] UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#define YHSINFOLog(format, ...) printf("[%s] [INFO] %s [第%d行] => %s \n", [[YHSDateTimeUtil getCurrentTimeStamp] UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#define YHSDEBUGLog(format, ...) printf("[%s] [DEBUG] %s [第%d行] => %s \n", [[YHSDateTimeUtil getCurrentTimeStamp] UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define YHSLog(__FORMAT__, ...)
#define YHSINFOLog(__FORMAT__, ...)
#define YHSDEBUGLog(__FORMAT__, ...)
#endif


#endif /* YHSSysLogMacro_h */



