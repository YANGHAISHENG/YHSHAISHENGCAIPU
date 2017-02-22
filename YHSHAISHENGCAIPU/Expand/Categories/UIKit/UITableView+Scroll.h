//
//  UITableView+Scroll.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Scroll)

- (void)scrollTableToTopAnimated:(BOOL)animated;

- (void)scrollTableToBottomAnimated:(BOOL)animated;

- (NSIndexPath *)firstIndexPath;

- (NSIndexPath *)lastIndexPath;

@end
