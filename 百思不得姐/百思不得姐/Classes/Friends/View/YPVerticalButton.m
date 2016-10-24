//
//  YPVerticalButton.m
//  百思不得姐
//
//  Created by yupeng on 16/8/12.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPVerticalButton.h"

@implementation YPVerticalButton


-(void)setUp{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)awakeFromNib{
    
    [self setUp];
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

/**
 *  重新布局子控件
 */

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //调整图片(imageView的x和y属性值默认不为0)
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
