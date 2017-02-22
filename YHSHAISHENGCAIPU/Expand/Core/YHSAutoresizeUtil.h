//
//  YHSAutoresizeUtil.h
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, iPhoneAutosizeType){
    iPhoneAutosizeTypeW320H480, // 320*480 iPhone4
    iPhoneAutosizeTypeW320H568, // 320*568 iPhone5
    iPhoneAutosizeTypeW375H667, // 375*667 iPhone6
    iPhoneAutosizeTypeW414H736, // 414*736 iPhone6Plus
    iPhoneAutosizeTypeUnKnown
};


@interface YHSAutoresizeUtil : NSObject


#pragma mark - 以iPhone7的屏幕为基准进行适配
UIKIT_EXTERN CGFloat const IPHONE_BASIC_WIDTH;
UIKIT_EXTERN CGFloat const IPHONE_BASIC_HEIGHT;


#pragma mark - 适配视图宽度
+ (CGFloat)getAutosizeViewWidth:(CGFloat)width;
#pragma mark - 适配视图高度
+ (CGFloat)getAutosizeViewHeight:(CGFloat)height;
#pragma mark - 适配字体大小
+ (CGFloat)getAutosizeFontSize:(CGFloat)fontSize;


#pragma mark - 获取适配类型
+ (iPhoneAutosizeType)getAutosizeType;


#pragma mark - 创建单例
+ (instancetype)sharedAutoresizeUtil;


@end




