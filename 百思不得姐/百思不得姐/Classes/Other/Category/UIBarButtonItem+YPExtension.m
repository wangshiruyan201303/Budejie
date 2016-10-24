//
//  UIBarButtonItem+YPExtension.m
//  百思不得姐
//
//  Created by yupeng on 16/8/8.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "UIBarButtonItem+YPExtension.h"

@implementation UIBarButtonItem (YPExtension)


+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    
    //设置左边item
    UIButton * button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[self alloc] initWithCustomView:button];
}

@end
