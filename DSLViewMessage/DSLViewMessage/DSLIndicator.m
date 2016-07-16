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

- (CALayer *)layerWithStyle:(DSLIndicatorStyle)style
{
    switch (style) {
        case DSLIndicatorStyle_0:
            return [self layerForStyle_0];
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
        default:
            return nil;
            break;
    }
}

- (CAShapeLayer *)layerForStyle_0
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_size / 2, _size / 2)
                                                        radius:_size / 2 - 2
                                                    startAngle:0
                                                      endAngle:1.8 * M_PI
                                                     clockwise:YES];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor blueColor].CGColor;
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

@end
