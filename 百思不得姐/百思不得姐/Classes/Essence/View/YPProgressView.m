//
//  YPProgressView.m
//  百思不得姐
//
//  Created by yupeng on 16/8/22.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPProgressView.h"

@implementation YPProgressView

-(void)awakeFromNib{
    
    self.roundedCorners = 5;
    self.progressLabel.textColor = [UIColor whiteColor];
    
}


-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
