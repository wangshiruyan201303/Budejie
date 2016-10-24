//
//  YPAddTagTextField.m
//  百思不得姐
//
//  Created by yupeng on 16/10/7.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPAddTagTextField.h"

@implementation YPAddTagTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.placeholder = @"输入标签，标签打得好，精华上得早";
        
        //设置textField占位文字颜色（只有先设置占位文字，才可以设置占位文字颜色）
        [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        self.height = 25;
    }
    
    return self;
}

/**
 * 实现UIKeyInput协议的方法
 */
-(void)deleteBackward
{
    
    //先调用block，再调用父类的方法，因为点击删除按钮时，最后一个字符删除的同时，hasText会变为0
    
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
}


@end
