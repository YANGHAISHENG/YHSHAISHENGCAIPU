//
//  YHSAutoresizeUtil.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "YHSAutoresizeUtil.h"


@implementation YHSAutoresizeUtil


#pragma mark - 以iPhone7的屏幕为基准进行适配
CGFloat const IPHONE_BASIC_WIDTH = 375.0;
CGFloat const IPHONE_BASIC_HEIGHT = 667.0;


#pragma mark - 适配视图宽度
+ (CGFloat)getAutosizeViewWidth:(CGFloat)width
{
    iPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    switch (autosizeType) {
        case iPhoneAutosizeTypeW320H480:
            return SCREEN_WIDTH*(width/IPHONE_BASIC_WIDTH);
        case iPhoneAutosizeTypeW320H568:
            return SCREEN_WIDTH*(width/IPHONE_BASIC_WIDTH);
        case iPhoneAutosizeTypeW375H667:
            return SCREEN_WIDTH*(width/IPHONE_BASIC_WIDTH);
        case iPhoneAutosizeTypeW414H736:
            return SCREEN_WIDTH*(width/IPHONE_BASIC_WIDTH);
        default:
            return SCREEN_WIDTH*(width/IPHONE_BASIC_WIDTH);
            break;
    }
}


#pragma mark - 适配视图高度
+ (CGFloat)getAutosizeViewHeight:(CGFloat)height
{
    iPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    switch (autosizeType) {
        case iPhoneAutosizeTypeW320H480:
            return SCREEN_HEIGHT*(height/IPHONE_BASIC_HEIGHT);
        case iPhoneAutosizeTypeW320H568:
            return SCREEN_HEIGHT*(height/IPHONE_BASIC_HEIGHT);
        case iPhoneAutosizeTypeW375H667:
            return SCREEN_HEIGHT*(height/IPHONE_BASIC_HEIGHT);
        case iPhoneAutosizeTypeW414H736:
            return SCREEN_HEIGHT*(height/IPHONE_BASIC_HEIGHT);
        default:
            return SCREEN_HEIGHT*(height/IPHONE_BASIC_HEIGHT);
            break;
    }
}


#pragma mark - 适配字体大小
+ (CGFloat)getAutosizeFontSize:(CGFloat)fontSize
{
    iPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    
    switch (autosizeType) {
        case iPhoneAutosizeTypeW320H480:
            return SCREEN_HEIGHT*(fontSize/IPHONE_BASIC_HEIGHT);
        case iPhoneAutosizeTypeW320H568:
            return SCREEN_HEIGHT*(fontSize/IPHONE_BASIC_HEIGHT);
        case iPhoneAutosizeTypeW375H667:
            return SCREEN_HEIGHT*(fontSize/IPHONE_BASIC_HEIGHT);
        case iPhoneAutosizeTypeW414H736:
            return SCREEN_HEIGHT*(fontSize/IPHONE_BASIC_HEIGHT);
        default:
            return SCREEN_HEIGHT*(fontSize/IPHONE_BASIC_HEIGHT);
            break;
    }
}


#pragma mark - 获取适配类型
+ (iPhoneAutosizeType)getAutosizeType
{
    //bounds method gets the points not the pixels!!!
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    //get current interface Orientation
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    //unknown
    if (UIInterfaceOrientationUnknown == orientation) {
        return iPhoneAutosizeTypeUnKnown;
    }
    
    // portrait:width * height
    // iPhone4 : 320 * 480
    // iPhone5 : 320 * 568
    // iPhone6 : 375 * 667
    // iPhone6Plus : 414 * 736
    
    // UIInterfaceOrientationLandscapeLeft 向左，即HOME键在右
    // UIInterfaceOrientationLandscapeRight 向右，即HOME键在左
    // UIInterfaceOrientationPortrait 正立，即HOME键在下
    // UIInterfaceOrientationPortraitUpsideDown 倒立，即HOME键在上
    
    // portrait
    if (UIInterfaceOrientationPortrait == orientation || UIDeviceOrientationPortraitUpsideDown == orientation) {
        if (width ==  320.0f) {
            if (height == 480.0f) {
                return iPhoneAutosizeTypeW320H480;
            } else {
                return iPhoneAutosizeTypeW320H568;
            }
        } else if (width == 375.0f) {
            return iPhoneAutosizeTypeW375H667;
        } else if (width == 414.0f) {
            return iPhoneAutosizeTypeW414H736;
        }
    }
    // landscape
    else if (UIInterfaceOrientationLandscapeLeft == orientation || UIInterfaceOrientationLandscapeRight == orientation) {
        if (height == 320.0) {
            if (width == 480.0f) {
                return iPhoneAutosizeTypeW320H480;
            } else {
                return iPhoneAutosizeTypeW320H568;
            }
        } else if (height == 375.0f) {
            return iPhoneAutosizeTypeW375H667;
        } else if (height == 414.0f) {
            return iPhoneAutosizeTypeW414H736;
        }
    }
    
    return iPhoneAutosizeTypeUnKnown;
}


#pragma mark - 创建单例
+ (instancetype)sharedAutoresizeUtil
{
    static YHSAutoresizeUtil *_singetonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (nil == _singetonInstance) {
            _singetonInstance = [[super allocWithZone:NULL] init];
        }
    });
    return _singetonInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedAutoresizeUtil];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedAutoresizeUtil];
}


@end




