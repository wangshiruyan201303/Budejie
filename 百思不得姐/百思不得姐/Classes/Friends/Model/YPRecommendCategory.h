//
//  YPRecommendCategory.h
//  百思不得姐
//
//  Created by yupeng on 16/8/9.
//  Copyright © 2016年 yupeng. All rights reserved.
//
//  推荐关注 左边的数据模型

#import <Foundation/Foundation.h>

@interface YPRecommendCategory : NSObject

/**
 *  类别名称
 */
@property (nonatomic,copy) NSString * name;
/**
 *  类别Id
 */
@property (nonatomic,assign) NSInteger ID;
/**
 *  类别右边数据个数
 */
@property (nonatomic,assign) NSInteger  count;

/**
 *  类别用户数据数组（存放一个类别对应的所有用户）
 */
@property (nonatomic,strong) NSMutableArray * users;
/**
 *  一个类别对应的用户总数
 */
@property (nonatomic,assign) NSInteger  total;
/**
 *  类别的当前页码
 */
@property (nonatomic,assign) NSInteger  currentPage;

@end
