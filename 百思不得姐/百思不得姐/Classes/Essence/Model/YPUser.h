//
//  YPUser.h
//  百思不得姐
//
//  Created by yupeng on 16/8/25.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPUser : NSObject

/**
 *  用户名
 */
@property (nonatomic,copy) NSString *username;
/**
 *  用户性别
 */
@property (nonatomic,copy) NSString *sex;
/**
 *  用户头像
 */
@property (nonatomic,copy) NSString *profile_image;

@end
