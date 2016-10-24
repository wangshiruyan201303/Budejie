//
//  YPComment.h
//  百思不得姐
//
//  Created by yupeng on 16/8/25.
//  Copyright © 2016年 yupeng. All rights reserved.
//  用户评论模型

#import <Foundation/Foundation.h>

@class  YPUser;

@interface YPComment : NSObject
/**
 *  评论ID
 */
@property (nonatomic,copy) NSString * ID;

/**
 *  评论音频时长
 */
@property (nonatomic,assign) NSInteger voicetime;
/**
 *  音频评论URL
 */
@property (nonatomic,copy) NSString * voiceuri;

/**
 *  评论的内容
 */
@property (nonatomic,copy) NSString *content;
/**
 *  点赞数
 */
@property (nonatomic,assign) NSInteger like_count;
/**
 *  用户模型
 */
@property (nonatomic,strong) YPUser *user;

@end
