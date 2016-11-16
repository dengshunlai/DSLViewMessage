//
//  DSLViewMessageManager.h
//  DSLViewMessage
//
//  Created by qwb on 16/8/4.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSLViewMessageManager : NSObject

/**
 *  indicator的颜色，对某些样式的indicator没有效果
 */
@property (strong, nonatomic) UIColor *indicatorTintColor;

/**
 *  indicator的大小
 */
@property (assign, nonatomic) CGFloat indicatorSize;

/**
 *  indicator样式为0时有效
 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

/**
 *  返回单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

@end
