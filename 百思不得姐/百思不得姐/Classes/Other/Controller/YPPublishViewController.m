//
//  YPPublishViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/23.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPPublishViewController.h"
#import "YPVerticalButton.h"
#import "YPPostWordViewController.h"
#import "YPNavigationController.h"
#import "YPTabBarController.h"



@interface YPPublishViewController ()

@end

@implementation YPPublishViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    //添加标语
    UIImageView * slogan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    slogan.y = YPScreenH * 0.2;
    slogan.centerX = YPScreenW * 0.5;
    [self.view addSubview:slogan];
    
    //添加六个button
    
    //图片和文字数组
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (YPScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (YPScreenW - maxCols * buttonW - 2 * buttonStartX) / (maxCols - 1);
    for (int i = 0; i <  images.count; i++) {
        YPVerticalButton *button = [[YPVerticalButton alloc] init];
        
        //给按钮绑定标签
        button.tag = i;
        
        //添加按钮监听事件
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置内容
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //设置frame
        button.width = buttonW;
        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = buttonStartY + row * buttonH;
        
        [self.view addSubview:button];
    }
    
}

-(void)buttonClicked:(YPVerticalButton *)button{
    
    if (button.tag == 2) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        YPPostWordViewController * postVC = [[YPPostWordViewController alloc] init];
        YPNavigationController  * nav = [[YPNavigationController alloc] initWithRootViewController:postVC];
        
        //这里不能用self来弹出postVC控制器，因为自己执行了dismiss操作。
        YPTabBarController * root = (YPTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        [root presentViewController:nav animated:YES completion:nil];
    }
}




- (IBAction)cancelBtnClicked {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
