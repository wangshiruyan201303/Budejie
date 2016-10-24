//
//  YPFriendTrendsViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPFriendTrendsViewController.h"
#import "YPRecommendViewController.h"
#import "YPLoginRegistViewController.h"

@interface YPFriendTrendsViewController ()

@end

@implementation YPFriendTrendsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    
    //设置左边item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendBtnClick)];
    
    //设置视图的背景色
    self.view.backgroundColor = YPRGBColor(233, 233, 233);
    
}
-(void)friendBtnClick{
    
    YPRecommendViewController * vc = [[YPRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)LoginOrRegist {
    
    YPLoginRegistViewController * loginRegist = [[YPLoginRegistViewController alloc] init];
    [self.navigationController presentViewController:loginRegist animated:YES completion:nil];
    
    
}


@end
