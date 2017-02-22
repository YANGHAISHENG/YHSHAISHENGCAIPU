//
//  YHSNavigationBarView.m
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//
// 使用 self.navigationItem.titleView 来设置titleview，并且要求达到和屏幕一样宽时，导航条两边总
// 是留出部分“空隙”。查找相关资料，达到的解决方案如下：继承UIView, 重写其中的setFrame方法。
//

#import "YHSNavigationBarView.h"

@implementation YHSNavigationBarView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];
}


@end


