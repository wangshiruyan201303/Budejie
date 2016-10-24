//
//  YPTabBar.m
//  百思不得姐
//
//  Created by yupeng on 16/8/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPTabBar.h"
#import "YPPublishViewController.h"

@interface YPTabBar()

@property (nonatomic,weak) UIButton * publishBtn;

@end


@implementation YPTabBar



-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 设置底部导航条的背景图片
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        //添加子控件
        UIButton * publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮背景图片
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishBtn addTarget:self action:@selector(publishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:publishBtn];
        
        self.publishBtn = publishBtn;
        
    }
    
    return self;
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置按钮center和bounds
    self.publishBtn.width = self.publishBtn.currentBackgroundImage.size.width;
    self.publishBtn.height = self.publishBtn.currentBackgroundImage.size.height;
    self.publishBtn.center = CGPointMake(width * 0.5, height * 0.5);
    

    
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    //设置tabBar子控件的frame
    for (UIView * button in self.subviews) {
        if ( ![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        CGFloat buttonX = buttonW * ((index > 1)? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //索引增加
        index ++;
    
    }
}

/**
 *  modal出发布界面
 */
-(void)publishBtnClicked{
    
    
    YPPublishViewController *publishVC = [[YPPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}

@end
