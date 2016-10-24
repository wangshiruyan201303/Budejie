//
//  YPPushGuideView.m
//  百思不得姐
//
//  Created by yupeng on 16/8/15.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPPushGuideView.h"

@implementation YPPushGuideView

+(instancetype)guideView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+(void)show{
    
    
    NSString * key = @"CFBundleShortVersionString";
    //获得当前软件的版本号
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获得沙盒中存储的上次软件版本号
    NSString * sandBoxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    //判断本次打开软件的版本号和上次是否相同
    if (![currentVersion isEqualToString:sandBoxVersion]) {
        //如果不相等，则推送引导
        YPPushGuideView * guideView = [YPPushGuideView guideView];
        //获得主窗口
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)closeBtnClicked {
    
    //将引导界面删除
    [self removeFromSuperview];
}


@end
