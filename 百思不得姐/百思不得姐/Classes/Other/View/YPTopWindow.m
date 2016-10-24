//
//  YPTopWindow.m
//  百思不得姐
//
//  Created by yupeng on 16/10/2.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPTopWindow.h"



@implementation YPTopWindow

static UIWindow * window_;

+(void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, YPScreenW, 5);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor blackColor];
    window_.alpha = 0.2;
    window_.rootViewController = [[UIViewController alloc] init];
    [window_  addGestureRecognizer:[[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(windowClick)]];
}

/**
 * 监听窗口点击
 */
+(void)windowClick{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInSuperView:window];
}

+(void)searchScrollViewInSuperView:(UIView *)superView{
    
    for (UIScrollView * subView in superView.subviews ) {
        if ([subView isKindOfClass:[UIScrollView class]]  && subView.isShowingOnKeyWindow) {
            CGPoint offset = subView.contentOffset;
            offset.y = - subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        
        //继续查找子控件
        [self searchScrollViewInSuperView:subView];
    }
}


+(void)show{
    window_.hidden = NO;
}


@end
