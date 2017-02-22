//
//  BannerADTableViewCell.h
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BannerADModel;

UIKIT_EXTERN CGFloat const SCROLL_AD_HEIGHT;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_BANNER_AD;

@protocol BannerADTableViewCellDelegate <NSObject>
@optional
- (void)didSelectRowAtBannerADModel:(BannerADModel *)model;
@end


@interface BannerADTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<BannerADModel *> *model;

@property (nonatomic, weak) id<BannerADTableViewCellDelegate> delegate;

@end


