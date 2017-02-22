//
//  UIColor+System.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "UIColor+System.h"
#import "UIColor+Hex.h"

@implementation UIColor (System)

+ (UIColor *)systemBlueColor
{
    static UIColor *_systemBlueColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _systemBlueColor = [UIColor colorFromHex:@"007AFF"];
    });
    return _systemBlueColor;
}

+ (UIColor *)systemRedColor
{
    static UIColor *_systemRedColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _systemRedColor = [UIColor colorFromHex:@"FF3B30"];
    });
    return _systemRedColor;
}

+ (UIColor *)systemGreenColor
{
    static UIColor *_systemGreenColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _systemGreenColor = [UIColor colorFromHex:@"4CD964"];
    });
    return _systemGreenColor;
}

+ (UIColor *)systemGreyColor
{
    static UIColor *_systemGreyColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _systemGreyColor = [UIColor colorFromHex:@"8E8E93"];
    });
    return _systemGreyColor;
}



@end
