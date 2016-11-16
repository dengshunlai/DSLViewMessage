//
//  DSLIndicator.m
//  DSLViewMessage
//
//  Created by 邓顺来 on 16/7/16.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "DSLIndicator.h"
#import "DSLViewMessageManager.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static CGFloat const kSize = 30;
static NSInteger const kStyle = DSLIndicatorStyle_0;

@interface DSLIndicator ()

@property (assign, nonatomic) CGFloat size;
@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) DSLIndicatorStyle style;

@property (assign, nonatomic) CALayer *indicatorLayer;

@end

@implementation DSLIndicator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _size = kSize;
        _style = kStyle;
    }
    return self;
}

+ (DSLIndicator *)indicatorWithStyle:(DSLIndicatorStyle)style
{
    return [self indicatorWithStyle:style size:kSize color:UIColorFromRGB(0x0080ff)];
}

+ (DSLIndicator *)indicatorWithStyle:(DSLIndicatorStyle)style size:(CGFloat)size color:(UIColor *)color
{
    DSLIndicator *indicator = [[DSLIndicator alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    indicator.size = size;
    indicator.color = color;
    indicator.style = style;
    return indicator;
}

- (void)starAnimation
{
    if (_style == 0) {
        DSLViewMessageManager *manager = [DSLViewMessageManager sharedInstance];
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:manager.activityIndicatorViewStyle];
        activityView.frame = CGRectMake(0, 0, _size, _size);
        [self addSubview:activityView];
        [activityView startAnimating];
        return ;
    }
    _indicatorLayer = [self layerWithStyle:_style];
    [self.layer addSublayer:_indicatorLayer];
}

- (void)removeAnimation
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [_indicatorLayer removeAllAnimations];
}

- (CALayer *)layerWithStyle:(DSLIndicatorStyle)style
{
    NSString *selectorName = [NSString stringWithFormat:@"layerForStyle_%ld",style];
    SEL selector = NSSelectorFromString(selectorName);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    CALayer *layer = [self performSelector:selector];
#pragma clang diagnostic pop
    return layer;
}

#pragma mark - layer & animation

- (CALayer *)layerForStyle_1
{
    CGFloat size = _size + 20;
    CGFloat dotSize = 10;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(-10, -10, size, size);
    
    CALayer *redCircleLayer = [CALayer layer];
    redCircleLayer.frame = CGRectMake(0, size / 2 - dotSize / 2, dotSize, dotSize);
    redCircleLayer.backgroundColor = [UIColor redColor].CGColor;
    redCircleLayer.cornerRadius = 5;
    redCircleLayer.masksToBounds = YES;
    
    CALayer *grayCircleLayer = [CALayer layer];
    grayCircleLayer.frame = CGRectMake(size / 2 - dotSize / 2, size / 2 - dotSize / 2, dotSize, dotSize);
    grayCircleLayer.backgroundColor = [UIColor grayColor].CGColor;
    grayCircleLayer.cornerRadius = 5;
    grayCircleLayer.masksToBounds = YES;
    
    CALayer *blueCircleLayer = [CALayer layer];
    blueCircleLayer.frame = CGRectMake(size - dotSize, size / 2 - dotSize / 2, dotSize, dotSize);
    blueCircleLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueCircleLayer.cornerRadius = 5;
    blueCircleLayer.masksToBounds = YES;
    
    [layer addSublayer:redCircleLayer];
    [layer addSublayer:grayCircleLayer];
    [layer addSublayer:blueCircleLayer];
    
    CABasicAnimation *redAnimation = [CABasicAnimation animation];
    redAnimation.keyPath = @"transform";
    redAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    redAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(size - dotSize, 0, 0)];
    redAnimation.repeatCount = INFINITY;
    redAnimation.duration = 1;
    redAnimation.autoreverses = YES;
    redAnimation.removedOnCompletion = NO;
    redAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *blueAnimation = [CABasicAnimation animation];
    blueAnimation.keyPath = @"transform";
    blueAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    blueAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-size + dotSize, 0, 0)];
    blueAnimation.repeatCount = INFINITY;
    blueAnimation.duration = 1;
    blueAnimation.autoreverses = YES;
    blueAnimation.removedOnCompletion = NO;
    blueAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [redCircleLayer addAnimation:redAnimation forKey:@"red"];
    [blueCircleLayer addAnimation:blueAnimation forKey:@"blue"];
    return layer;
}

- (CAShapeLayer *)layerForStyle_2
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_size / 2, _size / 2)
                                                        radius:_size / 2 - 1
                                                    startAngle:0
                                                      endAngle:1.6 * M_PI
                                                     clockwise:YES];
    path.lineWidth = 2;
    layer.path = path.CGPath;
    layer.strokeColor = _color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = CGRectMake(0, 0, _size, _size);
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);
    animation.duration = 1;
    animation.repeatCount = INFINITY;
    animation.removedOnCompletion = NO;
    
    [layer addAnimation:animation forKey:@"style_2"];
    return layer;
}

- (CAShapeLayer *)layerForStyle_3
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, _size, _size)];
    layer.path = path.CGPath;
    layer.fillColor = _color.CGColor;
    layer.frame = CGRectMake(0, 0, _size, _size);
    
    CABasicAnimation *xAnimation = [CABasicAnimation animation];
    xAnimation.keyPath = @"transform.rotation.x";
    xAnimation.fromValue = @(0);
    xAnimation.toValue = @(M_PI);
    xAnimation.beginTime = 0;
    xAnimation.duration = 0.6;
    
    CABasicAnimation *yAnimation = [CABasicAnimation animation];
    yAnimation.keyPath = @"transform.rotation.y";
    yAnimation.fromValue = @(0);
    yAnimation.toValue = @(M_PI);
    yAnimation.beginTime = 0.6;
    yAnimation.duration = 0.6;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[xAnimation, yAnimation];
    group.duration = 1.2;
    group.repeatCount = INFINITY;
    group.removedOnCompletion = NO;
    
    [layer addAnimation:group forKey:@"style_3"];
    return layer;
}

- (CAShapeLayer *)layerForStyle_4
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_size / 2, _size / 2)
                                                        radius:_size / 2 - 1
                                                    startAngle:0
                                                      endAngle:2 * M_PI
                                                     clockwise:YES];
    path.lineWidth = 2;
    layer.path = path.CGPath;
    layer.strokeColor = _color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = CGRectMake(0, 0, _size, _size);
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation.z";
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(2 * M_PI);
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animation];
    strokeStartAnimation.keyPath = @"strokeStart";
    strokeStartAnimation.fromValue = @(0);
    strokeStartAnimation.toValue = @(1);
    strokeStartAnimation.beginTime = 0;
    strokeStartAnimation.duration = 0.7;
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animation];
    strokeEndAnimation.keyPath = @"strokeEnd";
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    strokeEndAnimation.beginTime = 0.7;
    strokeEndAnimation.duration = 0.7;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotationAnimation, strokeStartAnimation, strokeEndAnimation];
    group.duration = 1.4;
    group.repeatDuration = INFINITY;
    group.removedOnCompletion = NO;
    group.timeOffset = .5;
    
    [layer addAnimation:group forKey:@"style_4"];
    return layer;
}

@end
