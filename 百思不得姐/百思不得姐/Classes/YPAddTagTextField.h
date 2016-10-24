//
//  YPAddTagTextField.h
//  百思不得姐
//
//  Created by yupeng on 16/10/7.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPAddTagTextField : UITextField

/**
 * textField的block，用于在监听到删除按钮点击时的回调
 */
@property (nonatomic,copy) void(^deleteBlock)();


@end
