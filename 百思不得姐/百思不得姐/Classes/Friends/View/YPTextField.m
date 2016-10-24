//
//  YPTextField.m
//  百思不得姐
//
//  Created by yupeng on 16/8/12.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPTextField.h"

static NSString * const YPPlaceholderColorKeyPath = @"_placeholderLabel.textColor";


@implementation YPTextField

-(void)awakeFromNib{
    
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    //不成为第一响应者
    [self resignFirstResponder];
    
}

/**
 *  当文本框聚焦时就会调用
 */
-(BOOL)becomeFirstResponder{
    
    //修改占位符文字颜色
    [self setValue:self.textColor forKeyPath:YPPlaceholderColorKeyPath];
    return  [super becomeFirstResponder];
}

/**
 *  当文本框失去焦点时就会调用
 */

-(BOOL)resignFirstResponder{
    
    //修改占位符文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:YPPlaceholderColorKeyPath];
    return [super resignFirstResponder];
    
}
@end
