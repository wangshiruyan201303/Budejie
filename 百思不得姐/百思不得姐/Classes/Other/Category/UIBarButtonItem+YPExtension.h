//
//  UIBarButtonItem+YPExtension.h
//  百思不得姐
//
//  Created by yupeng on 16/8/8.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YPExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)image target:(id)target action:(SEL)action;

@end
