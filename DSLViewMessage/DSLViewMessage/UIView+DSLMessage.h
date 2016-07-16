//
//  UIView+DSLMessage.h
//  videoForHearthstone
//
//  Created by 邓顺来 on 16/7/9.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSLIndicator.h"

/******************************************************************************************************************************
 *
 *  您可以对View或View的子类使用下面的方法
 *
 *  如发现bug或有其他建议，欢迎与我联系
 *  mu3305495@163.com
 *  qq:339629426
 *
 *******************************************************************************************************************************/

typedef void(^ButtonClickBlock)(UIButton *button);

@interface UIView (DSLMessage)

/**
 *  信息显示方法，不需要的部分传nil/0
 *
 *  @param message    文本
 *  @param subMessage 子文本
 *  @param image      图片
 *  @param buttonText 按钮文字
 *  @param block      按钮点击block
 *  @param yOffset    在y轴上的偏移，默认0
 */
- (void)dsl_showMessage:(NSString *)message
             subMessage:(NSString *)subMessage
                  image:(UIImage *)image
             buttonText:(NSString *)buttonText
       buttonClickBlock:(ButtonClickBlock)block
                yOffset:(CGFloat)yOffset;

- (void)dsl_showMessage:(NSString *)message
             subMessage:(NSString *)subMessage
                  image:(UIImage *)image
             buttonText:(NSString *)buttonText
       buttonClickBlock:(ButtonClickBlock)block;

- (void)dsl_showMessage:(NSString *)message
             subMessage:(NSString *)subMessage
                  image:(UIImage *)image;

- (void)dsl_showMessage:(NSString *)message;

/**
 *  去除信息显示
 */
- (void)dsl_removeMessage;

/**
 *  指示器显示方法，不需要的部分传nil/0
 *
 *  @param style   指示器风格
 *  @param message 文本
 *  @param isLimit 是否限制交互，默认否
 *  @param yOffset y轴上的偏移，默认0
 */
- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style
                          message:(NSString *)message
                            limit:(BOOL)isLimit
                          yOffset:(CGFloat)yOffset;

- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style
                          message:(NSString *)message
                            limit:(BOOL)isLimit;

- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style
                            limit:(BOOL)isLimit;

- (void)dsl_showIndicatorWithMessage:(NSString *)message
                               limit:(BOOL)isLimit;

- (void)dsl_showIndicatorWithMessage:(NSString *)message;

- (void)dsl_showIndicatorWithLimit:(BOOL)isLimit;

- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style;

- (void)dsl_showIndicator;

/**
 *  去除指示器
 */
- (void)dsl_removeIndicator;

@end
