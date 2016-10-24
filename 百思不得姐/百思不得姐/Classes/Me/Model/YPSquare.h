//
//  YPSquare.h
//  百思不得姐
//
//  Created by yupeng on 16/10/4.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPSquare : NSObject
/**
 * 方块的图片地址
 */
@property (nonatomic,copy) NSString * icon;
/**
 * 方块的label名称
 */
@property (nonatomic,copy) NSString * name;
/**
 * 点击方块的链接
 */
@property (nonatomic,copy) NSString * url;

@end
