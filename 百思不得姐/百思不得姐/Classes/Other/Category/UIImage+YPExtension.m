//
//  UIImage+YPExtension.m
//  百思不得姐
//
//  Created by yupeng on 16/10/3.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "UIImage+YPExtension.h"

@implementation UIImage (YPExtension)

/**
 * 返回一张图片的圆形图片
 */

-(UIImage *)circleImage{
    
    
    //开启图片上下文 opaque= No 表示透明
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加一个圆
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    //裁剪
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    
    //将图片画上去
    
    [self drawInRect:rect];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //返回圆形图片
    return image;
}


@end
