//
//  ViewController.m
//  DSLViewMessage
//
//  Created by 邓顺来 on 16/7/13.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "ViewController.h"
#import "UIView+DSLMessage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //@"请检查网络链接" //@"加载失败" //@"点击重新加载" //[UIImage imageNamed:@"error"]
    [self.view dsl_showMessage:@"请检查网络链接" subMessage:@"加载失败" buttonText:@"点击重新加载" image:[UIImage imageNamed:@"error"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view dsl_showMessage:@"请检查网络链接" subMessage:nil buttonText:nil image:nil];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
