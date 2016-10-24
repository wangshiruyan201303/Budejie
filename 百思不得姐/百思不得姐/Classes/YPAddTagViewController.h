//
//  YPAddTagViewController.h
//  百思不得姐
//
//  Created by yupeng on 16/10/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPAddTagViewController : UIViewController

/**
 *  点击"完成"按钮调用的block
 */
@property (nonatomic,copy) void(^addTagBlock)(NSArray * tags);
/**
 *  标签数组，接受从上个控制器传递过来的所有标签文字
 */
@property (nonatomic,strong) NSArray * tags;


@end
