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

@property (strong, nonatomic) UIImageView *dsl_msgImageView;
@property (strong, nonatomic) UIButton *dsl_msgButton;
@property (strong, nonatomic) UILabel *dsl_msgLable;
@property (strong, nonatomic) UILabel *dsl_subMsgLable;
@property (strong, nonatomic) UIView *dsl_msgContentView;

@property (copy, nonatomic) ButtonClickBlock dsl_msgButtonClickBlock;

@property (strong, nonatomic) UIView *dsl_indicatorView;
@property (strong, nonatomic) UIView *dsl_indicatorContentView;
@property (strong, nonatomic) UILabel *dsl_indicatorMsgLable;

@property (strong, nonatomic) NSMutableArray *dsl_viewMsg_selfConstraints;

@end

@implementation UIView (DSLMessage)

#pragma mark - objec_associated

- (UILabel *)dsl_msgLable
{
    UILabel *label = objc_getAssociatedObject(self, @selector(dsl_msgLable));
    if (!label) {
        self.dsl_msgLable = label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.textColor = UIColorFromRGB(0x666666);
        label.font = [UIFont systemFontOfSize:16];
        [self.dsl_msgContentView addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return label;
}

- (void)setDsl_msgLable:(UILabel *)dsl_msgLable
{
    objc_setAssociatedObject(self, @selector(dsl_msgLable), dsl_msgLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)dsl_subMsgLable
{
    UILabel *label = objc_getAssociatedObject(self, @selector(dsl_subMsgLable));
    if (!label) {
        self.dsl_subMsgLable= label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.textColor = UIColorFromRGB(0x999999);
        label.font = [UIFont systemFontOfSize:16];
        [self.dsl_msgContentView addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return label;
}

- (void)setDsl_subMsgLable:(UILabel *)dsl_subMsgLable
{
    objc_setAssociatedObject(self, @selector(dsl_subMsgLable), dsl_subMsgLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)dsl_msgButton
{
    UIButton *button = objc_getAssociatedObject(self, @selector(dsl_msgButton));
    if (!button) {
        self.dsl_msgButton = button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = UIColorFromRGB(0x666666).CGColor;
        button.layer.borderWidth = 1;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.dsl_msgContentView addSubview:button];
        button.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return button;
}

- (void)setDsl_msgButton:(UIButton *)dsl_msgButton
{
    objc_setAssociatedObject(self, @selector(dsl_msgButton), dsl_msgButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)dsl_msgImageView
{
    UIImageView *iv = objc_getAssociatedObject(self, @selector(dsl_msgImageView));
    if (!iv) {
        self.dsl_msgImageView = iv = [[UIImageView alloc] init];
        [self.dsl_msgContentView addSubview:iv];
        iv.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return iv;
}

- (void)setDsl_msgImageView:(UIImageView *)dsl_msgImageView
{
    objc_setAssociatedObject(self, @selector(dsl_msgImageView), dsl_msgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dsl_msgContentView
{
    UIView *view = objc_getAssociatedObject(self, @selector(dsl_msgContentView));
    if (!view) {
        self.dsl_msgContentView = view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.hidden = YES;
    }
    return view;
}

- (void)setDsl_msgContentView:(UIView *)dsl_msgContentView
{
    objc_setAssociatedObject(self, @selector(dsl_msgContentView), dsl_msgContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ButtonClickBlock)dsl_msgButtonClickBlock
{
    return objc_getAssociatedObject(self, @selector(dsl_msgButtonClickBlock));
}

- (void)setDsl_msgButtonClickBlock:(ButtonClickBlock)dsl_msgButtonClickBlock
{
    objc_setAssociatedObject(self, @selector(dsl_msgButtonClickBlock), dsl_msgButtonClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIView *)dsl_indicatorView
{
    UIView *view = objc_getAssociatedObject(self, @selector(dsl_indicatorView));
    if (!view) {
        self.dsl_indicatorView = view = [[UIView alloc] init];
        [self.dsl_indicatorContentView addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return view;
}

- (void)setDsl_indicatorView:(UIView *)dsl_indicatorView
{
    objc_setAssociatedObject(self, @selector(dsl_indicatorView), dsl_indicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)dsl_indicatorMsgLable
{
    UILabel *label = objc_getAssociatedObject(self, @selector(dsl_indicatorMsgLable));
    if (!label) {
        self.dsl_indicatorMsgLable = label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = UIColorFromRGB(0x888888);
        [self.dsl_indicatorContentView addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return label;
}

- (void)setDsl_indicatorMsgLable:(UILabel *)dsl_indicatorMsgLable
{
    objc_setAssociatedObject(self, @selector(dsl_indicatorMsgLable), dsl_indicatorMsgLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dsl_indicatorContentView
{
    UIView *view = objc_getAssociatedObject(self, @selector(dsl_indicatorContentView));
    if (!view) {
        self.dsl_indicatorContentView = view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.hidden = YES;
    }
    return view;
}

- (void)setDsl_indicatorContentView:(UIView *)dsl_indicatorContentView
{
    objc_setAssociatedObject(self, @selector(dsl_indicatorContentView), dsl_indicatorContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)dsl_indicatorContentViewConstraints
{
    return objc_getAssociatedObject(self, @selector(dsl_indicatorContentViewConstraints));
}

- (void)setDsl_indicatorContentViewConstraints:(NSArray *)dsl_indicatorContentViewConstraints
{
    objc_setAssociatedObject(self, @selector(dsl_indicatorContentViewConstraints), dsl_indicatorContentViewConstraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)dsl_viewMsg_selfConstraints
{
    return objc_getAssociatedObject(self, @selector(dsl_viewMsg_selfConstraints));
}

- (void)setDsl_viewMsg_selfConstraints:(NSMutableArray *)dsl_viewMsg_selfConstraints
{
    objc_setAssociatedObject(self, @selector(dsl_viewMsg_selfConstraints), dsl_viewMsg_selfConstraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - API

- (void)dsl_showMessage:(NSString *)message
{
    [self dsl_showMessage:message subMessage:nil image:nil buttonText:nil buttonClickBlock:nil yOffset:0];
}

- (void)dsl_showMessage:(NSString *)message yOffset:(CGFloat)yOffset
{
    [self dsl_showMessage:message subMessage:nil image:nil buttonText:nil buttonClickBlock:nil yOffset:yOffset];
}

- (void)dsl_showMessage:(NSString *)message
             subMessage:(NSString *)subMessage
                  image:(UIImage *)image
{
    [self dsl_showMessage:message subMessage:subMessage image:image buttonText:nil buttonClickBlock:nil yOffset:0];
}

- (void)dsl_showMessage:(NSString *)message
             subMessage:(NSString *)subMessage
                  image:(UIImage *)image
             buttonText:(NSString *)buttonText
       buttonClickBlock:(ButtonClickBlock)block
{
    [self dsl_showMessage:message subMessage:subMessage image:image buttonText:buttonText buttonClickBlock:block yOffset:0];
}

- (void)dsl_showMessageWithParams:(id)firstParam, ...
{
    va_list ap;
    va_start(ap, firstParam);
    NSString *message;
    NSString *subMessage;
    UIImage *image;
    NSString *buttonText;
    ButtonClickBlock block;
    CGFloat yOffset = 0.0;
    int index = 0;
    for (id param = firstParam; param != nil; param = va_arg(ap, id)) {
        switch (index) {
            case 0:
                message = param;
                break;
            case 1:
                subMessage = param;
                break;
            case 2:
                image = param;
                break;
            case 3:
                buttonText = param;
                break;
            case 4:
                block = param;
                break;
            case 5:
                yOffset = [param doubleValue];
                break;
            default:
                break;
        }
        index++;
    }
    va_end(ap);
    [self dsl_showMessage:message subMessage:subMessage image:image buttonText:buttonText buttonClickBlock:block yOffset:yOffset];
}

- (void)dsl_showMessage:(NSString *)message
             subMessage:(NSString *)subMessage
                  image:(UIImage *)image
             buttonText:(NSString *)buttonText
       buttonClickBlock:(ButtonClickBlock)block
                yOffset:(CGFloat)yOffset
{
    [self dsl_removeIndicator];
    
    self.dsl_msgLable.text = message;
    self.dsl_subMsgLable.text = subMessage;
    [self.dsl_msgButton setTitle:[NSString stringWithFormat:@"  %@  ",buttonText] forState:UIControlStateNormal];
    self.dsl_msgImageView.image = image;
    self.dsl_msgButtonClickBlock = block;
    
    [self.dsl_msgContentView removeConstraints:self.dsl_msgContentView.constraints];
    [self removeConstraints:self.dsl_viewMsg_selfConstraints];
    
    [self.dsl_msgContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_msgLable
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.dsl_msgContentView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1
                                                                         constant:0]];
    [self.dsl_msgContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_subMsgLable
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.dsl_msgContentView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1
                                                                         constant:0]];
    [self.dsl_msgContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_msgButton
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.dsl_msgContentView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1
                                                                         constant:0]];
    [self.dsl_msgContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_msgImageView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.dsl_msgContentView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1
                                                                         constant:0]];
    [self.dsl_msgContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[dsl_msgImageView(imageViewHeight)]-8-[dsl_msgLable]-5-[dsl_subMsgLable]-7-[dsl_msgButton(buttonHeight)]-5-|"
                                                                                    options:0
                                                                                    metrics:@{@"imageViewHeight":@(image ? image.size.height : 0),
                                                                                              @"buttonHeight":@(buttonText.length ? 32 : 0)}
                                                                                      views:@{@"dsl_msgImageView":self.dsl_msgImageView,
                                                                                              @"dsl_msgLable":self.dsl_msgLable,
                                                                                              @"dsl_subMsgLable":self.dsl_subMsgLable,
                                                                                              @"dsl_msgButton":self.dsl_msgButton}]];
    
    CGSize size = [self.dsl_msgContentView systemLayoutSizeFittingSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 1000)];
    
    NSMutableArray *selfConstraints = @[].mutableCopy;
    [selfConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dsl_msgContentView
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1
                                                             constant:0]];
    [selfConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dsl_msgContentView
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil attribute:0
                                                           multiplier:1
                                                             constant:size.width]];
    [selfConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dsl_msgContentView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:0
                                                           multiplier:1
                                                             constant:size.height]];
    [selfConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dsl_msgContentView
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1
                                                             constant:yOffset]];
    [self addConstraints:selfConstraints];
    self.dsl_viewMsg_selfConstraints = selfConstraints;
    self.dsl_msgContentView.hidden = NO;
}

- (void)dsl_removeMessage
{
    UIView *view = objc_getAssociatedObject(self, @selector(dsl_msgContentView));
    view.hidden = YES;
    self.userInteractionEnabled = YES;
}

- (void)dsl_showIndicator
{
    [self dsl_showIndicatorWithStyle:DSLIndicatorStyle_0 message:nil limit:YES yOffset:0];
}

- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style
{
    [self dsl_showIndicatorWithStyle:style message:nil limit:YES yOffset:0];
}

- (void)dsl_showIndicatorWithMessage:(NSString *)message
{
    [self dsl_showIndicatorWithStyle:DSLIndicatorStyle_0 message:message limit:YES yOffset:0];
}

- (void)dsl_showIndicatorWithLimit:(BOOL)isLimit
{
    [self dsl_showIndicatorWithStyle:DSLIndicatorStyle_0 message:nil limit:isLimit yOffset:0];
}

- (void)dsl_showIndicatorWithMessage:(NSString *)message limit:(BOOL)isLimit
{
    [self dsl_showIndicatorWithStyle:DSLIndicatorStyle_0 message:message limit:isLimit yOffset:0];
}

- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style limit:(BOOL)isLimit
{
    [self dsl_showIndicatorWithStyle:style message:nil limit:isLimit yOffset:0];
}

- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style message:(NSString *)message
{
    [self dsl_showIndicatorWithStyle:style message:message limit:YES yOffset:0];
}

- (void)dsl_showIndicatorWithMessage:(NSString *)message limit:(BOOL)isLimit yOffset:(CGFloat)yOffset
{
    [self dsl_showIndicatorWithStyle:DSLIndicatorStyle_0 message:message limit:isLimit yOffset:yOffset];
}

- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style message:(NSString *)message limit:(BOOL)isLimit
{
    [self dsl_showIndicatorWithStyle:style message:message limit:isLimit yOffset:0];
}

- (void)dsl_showIndicatorWithParams:(id)firstParam, ...
{
    va_list ap;
    va_start(ap, firstParam);
    DSLIndicatorStyle style = 0;
    NSString *message = nil;
    BOOL limit = YES;
    CGFloat yOffset = 0;
    int index = 0;
    for (id param = firstParam; param != nil; param = va_arg(ap, id)) {
        switch (index) {
            case 0:
                style = [param integerValue];
                break;
            case 1:
                message = param;
                break;
            case 2:
                limit = [param boolValue];
                break;
            case 3:
                yOffset = [param doubleValue];
                break;
            default:
                break;
        }
        index++;
    }
    va_end(ap);
    [self dsl_showIndicatorWithStyle:style message:message limit:limit yOffset:yOffset];
}

- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style message:(NSString *)message limit:(BOOL)isLimit yOffset:(CGFloat)yOffset
{
    [self dsl_removeMessage];
    
    self.dsl_indicatorMsgLable.text = message;
    for (UIView *view in self.dsl_indicatorView.subviews) {
        [view removeFromSuperview];
    }
    DSLViewMessageManager *manager = [DSLViewMessageManager sharedInstance];
    DSLIndicator *indicator = [DSLIndicator indicatorWithStyle:style size:manager.indicatorSize color:manager.indicatorTintColor];
    [self.dsl_indicatorView addSubview:indicator];
    indicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dsl_indicatorView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[indicator]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(indicator)]];
    [self.dsl_indicatorView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[indicator]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(indicator)]];
    
    [self.dsl_indicatorContentView removeConstraints:self.dsl_indicatorContentView.constraints];
    [self removeConstraints:self.dsl_viewMsg_selfConstraints];
    
    [self.dsl_indicatorContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_indicatorMsgLable
                                                                              attribute:NSLayoutAttributeCenterX
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.dsl_indicatorContentView
                                                                              attribute:NSLayoutAttributeCenterX
                                                                             multiplier:1
                                                                               constant:0]];
    [self.dsl_indicatorContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_indicatorView
                                                                              attribute:NSLayoutAttributeCenterX
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.dsl_indicatorContentView
                                                                              attribute:NSLayoutAttributeCenterX
                                                                             multiplier:1
                                                                               constant:0]];
    [self.dsl_indicatorContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_indicatorView
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:0
                                                                             multiplier:1
                                                                               constant:manager.indicatorSize]];
    [self.dsl_indicatorContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_indicatorView
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:0
                                                                             multiplier:1
                                                                               constant:manager.indicatorSize]];
    [self.dsl_indicatorContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_indicatorView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.dsl_indicatorContentView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:1
                                                                               constant:(message.length ? -manager.indicatorSize / 2 - 8 : 0) + yOffset]];
    if (message.length) {
        [self.dsl_indicatorContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dsl_indicatorMsgLable
                                                                                  attribute:NSLayoutAttributeTop
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.dsl_indicatorContentView
                                                                                  attribute:NSLayoutAttributeCenterY
                                                                                 multiplier:1
                                                                                   constant:yOffset]];
    }
    NSMutableArray *selfConstraints = @[].mutableCopy;
    [selfConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[dsl_indicatorContentView]|" options:0 metrics:nil views:@{@"dsl_indicatorContentView":self.dsl_indicatorContentView}]];
    [selfConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[dsl_indicatorContentView]|" options:0 metrics:nil views:@{@"dsl_indicatorContentView":self.dsl_indicatorContentView}]];
    //兼容scrollView及其子类
    [selfConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dsl_indicatorContentView
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1
                                                             constant:0]];
    [selfConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dsl_indicatorContentView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeHeight
                                                           multiplier:1
                                                             constant:0]];
    [self addConstraints:selfConstraints];
    self.dsl_viewMsg_selfConstraints = selfConstraints;
    [indicator starAnimation];
    self.dsl_indicatorContentView.hidden = NO;
    
    self.userInteractionEnabled = !isLimit;
}

- (void)dsl_removeIndicator
{
    UIView *view = objc_getAssociatedObject(self, @selector(dsl_indicatorContentView));
    view.hidden = YES;
    self.userInteractionEnabled = YES;
}

#pragma mark - Action

- (void)buttonClick:(UIButton *)sender
{
    if (self.dsl_msgButtonClickBlock) {
        self.dsl_msgButtonClickBlock(sender);
    }
}

@end
