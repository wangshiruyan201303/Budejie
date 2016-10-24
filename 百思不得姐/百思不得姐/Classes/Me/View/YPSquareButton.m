//
//  YPSquareButton.m
//  百思不得姐
//
//  Created by yupeng on 16/10/4.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPSquareButton.h"
#import "UIButton+WebCache.h"
#import "YPSquare.h"

@implementation YPSquareButton



-(void)awakeFromNib{
    
    [self setUp];
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
}

/**
 *  重新布局子控件
 */

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //调整图片
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

-(void)setSquare:(YPSquare *)square{
    
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}

@end
