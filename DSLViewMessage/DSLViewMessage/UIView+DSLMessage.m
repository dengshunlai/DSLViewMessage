//
//  UIView+DSLMessage.m
//  videoForHearthstone
//
//  Created by 邓顺来 on 16/7/9.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "UIView+DSLMessage.h"
#import <objc/runtime.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIView ()

@property (strong, nonatomic) UILabel *dsl_msgLable;

@end

@implementation UIView (DSLMessage)

- (UILabel *)dsl_msgLable
{
    UILabel *label = objc_getAssociatedObject(self, @selector(dsl_msgLable));
    if (!label) {
        label = self.dsl_msgLable = [self dsl_createMsgLabel];
    }
    return label;
}

- (void)setDsl_msgLable:(UILabel *)dsl_msgLable
{
    objc_setAssociatedObject(self, @selector(dsl_msgLable), dsl_msgLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)dsl_showMessage:(NSString *)message
{
    self.dsl_msgLable.hidden = NO;
    self.dsl_msgLable.text = message;
}

- (UILabel *)dsl_createMsgLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textColor = UIColorFromRGB(0x666666);
    [self addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    return label;
}

- (void)hideMessage
{
    UILabel *label = objc_getAssociatedObject(self, @selector(dsl_msgLable));
    label.hidden = YES;
}

@end
