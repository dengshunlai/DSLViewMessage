//
//  ViewController.m
//  DSLViewMessage
//
//  Created by 邓顺来 on 16/7/13.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "ViewController.h"
#import "UIView+DSLMessage.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)A:(UIBarButtonItem *)sender {
    //完整的显示方法
    [self.tableView dsl_showMessage:@"请检查网络链接"
                         subMessage:@"加载失败"
                              image:[UIImage imageNamed:@"error"]
                         buttonText:@"点击重新加载"
                   buttonClickBlock:^(UIButton *button) {
                                        NSLog(@"click button!");
                                    }
                            yOffset:0];
}

- (IBAction)B:(UIBarButtonItem *)sender {
    [self.tableView dsl_showMessage:@"请检查网络链接"];
}

- (IBAction)C:(UIBarButtonItem *)sender {
    [self.tableView dsl_showMessage:@"加载失败" subMessage:nil image:[UIImage imageNamed:@"error"]];
}

- (IBAction)E:(UIBarButtonItem *)sender {
    [self.tableView dsl_showMessage:nil subMessage:nil image:[UIImage imageNamed:@"error"]];
}

- (IBAction)F:(UIBarButtonItem *)sender {
    [self.tableView dsl_showMessage:@"请检查网络链接" subMessage:@"加载失败" image:nil];
}

- (IBAction)clear:(UIBarButtonItem *)sender {
    //去除信息
    [self.tableView dsl_removeMessage];
    //去除指示器
    [self.tableView dsl_removeIndicator];
}

- (IBAction)indicator:(UIBarButtonItem *)sender {
    [self.tableView dsl_showIndicatorWithStyle:DSLIndicatorStyle_0 message:@"载入中"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"cell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

@end
