//
//  DSLIndicator.h
//  DSLViewMessage
//
//  Created by 邓顺来 on 16/7/16.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DSLIndicatorStyle) {
    DSLIndicatorStyle_0 = 0,
    DSLIndicatorStyle_1,
    DSLIndicatorStyle_2
};

@interface DSLIndicator : UIView

+ (DSLIndicator *)indicatorWithStyle:(DSLIndicatorStyle)style;

+ (DSLIndicator *)indicatorWithStyle:(DSLIndicatorStyle)style size:(CGFloat)size;

- (void)starAnimation;

- (void)removeAnimation;

@end
