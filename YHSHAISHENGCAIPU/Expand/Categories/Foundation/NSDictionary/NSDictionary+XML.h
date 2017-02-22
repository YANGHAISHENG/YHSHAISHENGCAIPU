//
//  NSDictionary+XML.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XML)
/**
 *  @brief  将NSDictionary转换成XML字符串
 *
 *  @return XML 字符串
 */
- (NSString *)XMLString;
@end
