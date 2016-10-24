//
//  YPRecommendTag.h
//  百思不得姐
//
//  Created by yupeng on 16/8/11.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPRecommendTag : NSObject

/**
 *  头像
 */
@property (nonatomic,strong) NSString * image_list;
/**
 *  昵称
 */
@property (nonatomic,strong) NSString * theme_name;
/**
 *  订阅数
 */
@property (nonatomic,assign) NSInteger sub_number;

@end
