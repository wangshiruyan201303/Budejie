//
//  UIView+YPExtension.h
//  百思不得姐
//
//  Created by yupeng on 16/8/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YPExtension)

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;


/**
 * 判断一个控件是否真正显示在主窗口中
 */
-(BOOL)isShowingOnKeyWindow;
@end
