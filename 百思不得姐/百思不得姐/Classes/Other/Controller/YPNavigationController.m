//
//  YPNavigationController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/8. 13797090625
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPNavigationController.h"

@implementation YPNavigationController

/**
 *  这个方法只会在一个类第一次使用的时候才会调用 而且只会调用一次
 */
+(void)initialize{
    
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    //设置Item属性
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    NSMutableDictionary * enableDic = [NSMutableDictionary dictionary];
    enableDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    enableDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:enableDic forState:UIControlStateNormal];
    
    //disabled属性
    NSMutableDictionary * disabledDic = [NSMutableDictionary dictionary];
    disabledDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disabledDic[NSFontAttributeName] = enableDic[NSFontAttributeName];
    [item setTitleTextAttributes:disabledDic forState:UIControlStateDisabled];
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //如果向左滑动移除控制器的功能失效，可直接清空代理让功能还原
    //让导航控制器重新设置这个功能
    self.interactivePopGestureRecognizer.delegate = nil;
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    if (self.childViewControllers.count > 0) { //如果push进来的不是第一个控制器
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        button.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        //添加按钮监听事件，处理返回按钮的点击
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
        //将button作为导航栏左边的返回Item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //隐藏底部TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //这句super的push要放在push的后边，让viewController可以覆盖上边设置的leftBarButtonItem
    [super pushViewController:viewController animated:YES];
    
}

-(void)buttonClick{
    
    [self popViewControllerAnimated:YES];
}


@end
