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

@property (strong, nonatomic) UIView *dsl_msgContentView;

@property (strong, nonatomic) UIImageView *dsl_msgImageView;
@property (strong, nonatomic) UIButton *dsl_msgButton;
@property (strong, nonatomic) UILabel *dsl_msgLable;
@property (strong, nonatomic) UILabel *dsl_subMsgLable;

@property (strong, nonatomic) NSArray *dsl_msgContentViewConstraints;
@property (strong, nonatomic) NSArray *dsl_msgSelfConstraints;

@end

@implementation UIView (DSLMessage)

#pragma mark - objec_associated

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

- (UILabel *)dsl_subMsgLable
{
    UILabel *label = objc_getAssociatedObject(self, @selector(dsl_subMsgLable));
    if (!label) {
        label = self.dsl_subMsgLable = [self dsl_createSubMsgLabel];
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
        button = self.dsl_msgButton = [self dsl_createButton];
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
        iv = self.dsl_msgImageView = [self dsl_createImageView];
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
        view = self.dsl_msgContentView = [self dsl_createMsgContentView];
    }
    return view;
}

- (void)setDsl_msgContentView:(UIView *)dsl_msgContentView
{
    objc_setAssociatedObject(self, @selector(dsl_msgContentView), dsl_msgContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)dsl_msgContentViewConstraints
{
    return objc_getAssociatedObject(self, @selector(dsl_msgContentViewConstraints));
}

- (void)setDsl_msgContentViewConstraints:(NSArray *)dsl_msgContentViewConstraints
{
    objc_setAssociatedObject(self, @selector(dsl_msgContentViewConstraints), dsl_msgContentViewConstraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)dsl_msgSelfConstraints
{
    return objc_getAssociatedObject(self, @selector(dsl_msgSelfConstraints));
}

- (void)setDsl_msgSelfConstraints:(NSArray *)dsl_msgSelfConstraints
{
    objc_setAssociatedObject(self, @selector(dsl_msgSelfConstraints), dsl_msgSelfConstraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - API

- (void)dsl_showMessage:(NSString *)message
{
    self.dsl_msgLable.hidden = NO;
    self.dsl_msgLable.text = message;
}

- (void)dsl_showMessage:(NSString *)message subMessage:(NSString *)subMessage buttonText:(NSString *)buttonText image:(UIImage *)image
{
    self.dsl_msgLable.text = message;
    self.dsl_subMsgLable.text = subMessage;
    [self.dsl_msgButton setTitle:[NSString stringWithFormat:@" %@ ",buttonText] forState:UIControlStateNormal];
    self.dsl_msgImageView.image = image;
    
    [self.dsl_msgContentView removeConstraints:self.dsl_msgContentViewConstraints];
    [self removeConstraints:self.dsl_msgSelfConstraints];
    
    self.dsl_msgContentViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[dsl_msgImageView(imageViewHeight)]-8-[dsl_msgLable]-5-[dsl_subMsgLable]-6-[dsl_msgButton(buttonHeight)]-|"
                                                                                 options:0
                                                                                 metrics:@{@"imageViewHeight":@(image ? image.size.height : 0),
                                                                                           @"buttonHeight":@(buttonText.length ? 32 : 0)}
                                                                                   views:@{@"dsl_msgImageView":self.dsl_msgImageView,
                                                                                           @"dsl_msgLable":self.dsl_msgLable,
                                                                                           @"dsl_subMsgLable":self.dsl_subMsgLable,
                                                                                           @"dsl_msgButton":self.dsl_msgButton}];
    [self.dsl_msgContentView addConstraints:self.dsl_msgContentViewConstraints];
    
    CGSize size = [self.dsl_msgContentView systemLayoutSizeFittingSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 1000)];

    NSMutableArray *tempArr = @[].mutableCopy;
    [tempArr addObject:[NSLayoutConstraint constraintWithItem:self.dsl_msgContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:size.width]];
    [tempArr addObject:[NSLayoutConstraint constraintWithItem:self.dsl_msgContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:size.height]];
    self.dsl_msgSelfConstraints = tempArr;
    
    [self addConstraints:self.dsl_msgSelfConstraints];
    
    self.dsl_msgContentView.hidden = NO;
    
    NSLog(@"%ld,%ld",self.dsl_msgContentView.constraints.count,self.constraints.count);
    NSLog(@"%ld",self.dsl_subMsgLable.constraints.count);
}

#pragma mark - create UI

- (UILabel *)dsl_createMsgLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textColor = UIColorFromRGB(0x666666);
    [self.dsl_msgContentView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dsl_msgContentView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.dsl_msgContentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    return label;
}

- (UILabel *)dsl_createSubMsgLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textColor = UIColorFromRGB(0x999999);
    [self.dsl_msgContentView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dsl_msgContentView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.dsl_msgContentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    return label;
}

- (UIButton *)dsl_createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = UIColorFromRGB(0x666666).CGColor;
    button.layer.borderWidth = 1;
    [self.dsl_msgContentView addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dsl_msgContentView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.dsl_msgContentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    return button;
}

- (UIImageView *)dsl_createImageView
{
    UIImageView *iv = [[UIImageView alloc] init];
    [self.dsl_msgContentView addSubview:iv];
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dsl_msgContentView addConstraint:[NSLayoutConstraint constraintWithItem:iv attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.dsl_msgContentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    return iv;
}

- (UIView *)dsl_createMsgContentView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    view.hidden = YES;
    return view;
}

- (void)dsl_hideMessage
{
    UIView *view = objc_getAssociatedObject(self, @selector(dsl_msgContentView));
    view.hidden = YES;
}

@end
