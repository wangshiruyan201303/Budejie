//
//  YPNewViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPNewViewController.h"

@interface YPNewViewController ()

@end

@implementation YPNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的标题视图
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置左边item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(newBtnClick)];
    //设置视图的背景色
    self.view.backgroundColor = YPRGBColor(233, 233, 233);
}

-(void)newBtnClick{
    
    YPLogFunc
}

@end
