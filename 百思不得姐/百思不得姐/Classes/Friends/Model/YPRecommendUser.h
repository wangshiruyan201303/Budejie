//
//  YPRecommendUser.h
//  百思不得姐
//
//  Created by yupeng on 16/8/10.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPRecommendUser : NSObject

/**
 *  头像
 */
@property (nonatomic,copy) NSString * header;
/**
 *  粉丝数目
 */
@property (nonatomic,assign) NSInteger fans_count;
/**
 *  昵称
 */
@property (nonatomic,copy) NSString * screen_name;
@end
