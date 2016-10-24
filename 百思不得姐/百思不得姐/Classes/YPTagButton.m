//
//  YPTagButton.m
//  百思不得姐
//
//  Created by yupeng on 16/10/6.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPTagButton.h"

@implementation YPTagButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = YPRGBColor(74, 139, 209);
    }
    return self;
}

/** 
 * 重写setTitle方法，当文字发生改变时，重新计算按钮的frame
 */
-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    //让按钮宽度与文字匹配
    [self sizeToFit];
    
    //填充间距
    self.width += 3 * YPAddTagMargin;
    
    self.height = 35;
   
}

/**
 * 重新布局子控件
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = YPAddTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + YPAddTagMargin;
}

@end
