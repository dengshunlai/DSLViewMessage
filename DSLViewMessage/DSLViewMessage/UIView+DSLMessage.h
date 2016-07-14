//
//  UIView+DSLMessage.h
//  videoForHearthstone
//
//  Created by 邓顺来 on 16/7/9.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DSLMessage)

- (void)dsl_showMessage:(NSString *)message;

- (void)dsl_showMessage:(NSString *)message subMessage:(NSString *)subMessage buttonText:(NSString *)buttonText image:(UIImage *)image;

- (void)dsl_hideMessage;

@end
