//
//  YPLoginRegistViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/12.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPLoginRegistViewController.h"

@interface YPLoginRegistViewController ()

/**
 *  头部登录父控件距离控制器View的左边距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftMargin;

@end

@implementation YPLoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  设置当前控制器的状态栏为白色
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegist:(UIButton *)button {
    
    //退出键盘
    [self.view endEditing:YES];
   
    
    if (self.loginLeftMargin.constant == 0) {//显示注册界面
        self.loginLeftMargin.constant = - self.view.width;
        button.selected = YES;
    }
    else{ //显示登录界面
        self.loginLeftMargin.constant = 0;
        button.selected = NO;
    }
    
        [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}



@end
