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

- (void)hideMessage;

@end
