//
//  YPRecommendCategory.m
//  百思不得姐
//
//  Created by yupeng on 16/8/9.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPRecommendCategory.h"
#import "MJExtension.h"

@implementation YPRecommendCategory

/**
 *  用户数组懒加载
 */
-(NSMutableArray *)users{
    
    if (!_users) {
        
        _users = [NSMutableArray array];
        
    }
    return _users;
}

/**
 *  替换ID 为id 与服务器字段保持一致
 */
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID" : @"id"
             };
}

@end
