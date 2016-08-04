//
//  DSLViewMessageManager.m
//  DSLViewMessage
//
//  Created by qwb on 16/8/4.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "DSLViewMessageManager.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation DSLViewMessageManager

+ (instancetype)sharedInstance
{
    static id _shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    return _shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    _activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _indicatorTintColor = UIColorFromRGB(0x0080ff);
    _indicatorSize = 30;
}

@end
