//
//  YPPlaceholderTextView.m
//  百思不得姐
//
//  Created by yupeng on 16/10/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPPlaceholderTextView.h"

@implementation YPPlaceholderTextView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //设置弹簧效果一直存在
        self.alwaysBounceVertical = YES;
        
        //默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        //默认占位文字颜色
        self.placeholderColor = [UIColor lightGrayColor];
        
        //添加监听文字变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}


-(void)textDidChanged{
    
    [self setNeedsDisplay];
}



/**
 * 将占位文字绘制上去
 */
- (void)drawRect:(CGRect)rect {
    
    //如果有文字，则占位文字不需要再绘制上去（setNeedDisplay方法在调用drawRect方法时，它会将之前绘制的内容自动清除掉）
    if (self.hasText) return;
    
    //调整Rect的frame
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x ;
    
    //文字属性
    NSMutableDictionary * attars = [NSMutableDictionary dictionary];
    attars[NSForegroundColorAttributeName] = self.placeholderColor;
    attars[NSFontAttributeName] = self.font;
    
    //绘制文字
    [self.placeholder drawInRect:rect withAttributes:attars];
    
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 重写属性的setter方法，某些经常会修改的父类属性的setter方法也要重写

-(void)setPlaceholder:(NSString *)placeholder{
    
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
    
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text{
    
    [super setText:text];
    
    [self setNeedsDisplay];
    
}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}


@end
