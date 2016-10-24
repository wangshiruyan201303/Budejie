//
//  UIView+YPExtension.m
//  百思不得姐
//
//  Created by yupeng on 16/8/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "UIView+YPExtension.h"

@implementation UIView (YPExtension)


-(void)setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height{
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


-(void)setX:(CGFloat)x{
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setSize:(CGSize)size{
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}


-(void)setCenterY:(CGFloat)centerY{
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)width{
    
    return self.frame.size.width;
}


-(CGFloat)height{
    
    return self.frame.size.height;
}


-(CGFloat)x{
    
    return self.frame.origin.x;
}

-(CGFloat)y{
    
    return self.frame.origin.y;
}

-(CGSize)size{
    
    return self.frame.size;
}

-(CGFloat)centerX{
    
    return self.center.x;
}


-(CGFloat)centerY{
    
    return self.center.y;
}


-(BOOL)isShowingOnKeyWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //以主窗口左上角为坐标原点，计算self的frame
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect windowBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, windowBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;

    
}






@end
