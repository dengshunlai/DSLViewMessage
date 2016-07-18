//
//  DSLIndicator.m
//  DSLViewMessage
//
//  Created by 邓顺来 on 16/7/16.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "DSLIndicator.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static CGFloat const kSize = 50;
static NSInteger const kStyle = DSLIndicatorStyle_0;

@interface DSLIndicator ()

@property (assign, nonatomic) CGFloat size;
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
    return [self indicatorWithStyle:style size:kSize];
}

+ (DSLIndicator *)indicatorWithStyle:(DSLIndicatorStyle)style size:(CGFloat)size
{
    DSLIndicator *indicator = [[DSLIndicator alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    indicator.size = size;
    indicator.style = style;
    indicator.indicatorLayer = [indicator layerWithStyle:style];
    [indicator.layer addSublayer:indicator.indicatorLayer];
    return indicator;
}

- (void)starAnimation
{
    [_indicatorLayer addAnimation:[self animationWithStyle:_style] forKey:@"indicator"];
}

- (void)removeAnimation
{
    [_indicatorLayer removeAllAnimations];
}

- (CALayer *)layerWithStyle:(DSLIndicatorStyle)style
{
    switch (style) {
        case DSLIndicatorStyle_0:
            return [self layerForStyle_0];
            break;
        case DSLIndicatorStyle_1:
            return [self layerForStyle_1];
            break;
        case DSLIndicatorStyle_2:
            return [self layerForStyle_2];
            break;
        default:
            return nil;
            break;
    }
}

- (CAAnimation *)animationWithStyle:(DSLIndicatorStyle)style
{
    switch (style) {
        case DSLIndicatorStyle_0:
            return [self animationForStyle_0];
            break;
        case DSLIndicatorStyle_1:
            return [self animationForStyle_1];
            break;
        case DSLIndicatorStyle_2:
            return [self animationForStyle_2];
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - layer & animation

- (CAShapeLayer *)layerForStyle_0
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_size / 2, _size / 2)
                                                        radius:_size / 2 - 1
                                                    startAngle:0
                                                      endAngle:1.8 * M_PI
                                                     clockwise:YES];
    path.lineWidth = 2;
    layer.path = path.CGPath;
    layer.strokeColor = UIColorFromRGB(0x0080ff).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = CGRectMake(0, 0, _size, _size);
    return layer;
}

- (CABasicAnimation *)animationForStyle_0
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);
    animation.duration = 1;
    animation.repeatCount = INFINITY;
    return animation;
}

- (CAShapeLayer *)layerForStyle_1
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, _size, _size)];
    layer.path = path.CGPath;
    layer.fillColor = UIColorFromRGB(0x0080ff).CGColor;
    layer.frame = CGRectMake(0, 0, _size, _size);
    return layer;
}

- (CAAnimationGroup *)animationForStyle_1
{
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
    
    return group;
}

- (CAShapeLayer *)layerForStyle_2
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_size / 2, _size / 2)
                                                        radius:_size / 2 - 1
                                                    startAngle:0
                                                      endAngle:1.8 * M_PI
                                                     clockwise:YES];
    path.lineWidth = 2;
    layer.path = path.CGPath;
    layer.strokeColor = UIColorFromRGB(0x0080ff).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = CGRectMake(0, 0, _size, _size);
    return layer;
}

- (CAAnimationGroup *)animationForStyle_2
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation.z";
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(2 * M_PI);
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animation];
    strokeStartAnimation.keyPath = @"strokeStart";
    strokeStartAnimation.fromValue = @(0);
    strokeStartAnimation.toValue = @(1);
    strokeStartAnimation.beginTime = 0;
    strokeStartAnimation.duration = 0.6;
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animation];
    strokeEndAnimation.keyPath = @"strokeEnd";
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    strokeEndAnimation.beginTime = 0.6;
    strokeEndAnimation.duration = 0.6;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotationAnimation, strokeStartAnimation, strokeEndAnimation];
    group.duration = 1.2;
    group.repeatCount = INFINITY;
    
    return group;
}

@end
