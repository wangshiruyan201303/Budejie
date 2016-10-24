//
//  YPTabBarController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPTabBarController.h"
#import "YPEssenceViewController.h"
#import "YPFriendTrendsViewController.h"
#import "YPNewViewController.h"
#import "YPMeViewController.h"
#import "YPTabBar.h"
#import "YPNavigationController.h"

@interface YPTabBarController ()

@end

@implementation YPTabBarController


+(void)initialize{
    
    //通过appearance统一设置所有的UITabBarItem文字属性
    //后面带有UI_APPEARNCE_SELECTOR的方法，都可以通过appearance队形来统一设置
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    UITabBarItem * item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary * selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self setupChildVC:[[YPEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];

    [self setupChildVC:[[YPNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVC:[[YPFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVC:[[YPMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //利用KVC将系统的TabBar替换掉
    [self setValue:[[YPTabBar alloc] init] forKeyPath:@"tabBar"];
}

-(void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    //设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];

    
    //用导航控制器包装VC，并将导航控制器添加为子控制器
    YPNavigationController * nav = [[YPNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

@end
