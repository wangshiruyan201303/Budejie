//
//  YPPlaceholderTextView.h
//  百思不得姐
//
//  Created by yupeng on 16/10/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPPlaceholderTextView : UITextView

/**
 * 占位文字内容
 */
@property (nonatomic,copy) NSString * placeholder;
/**
 * 占位文字颜色
 */
@property (nonatomic,strong) UIColor * placeholderColor;

@end
