//
//  YPTopic.h
//  百思不得姐
//
//  Created by yupeng on 16/8/17.
//  Copyright © 2016年 yupeng. All rights reserved.
//  段子模型

#import <Foundation/Foundation.h>

@class YPComment;

@interface YPTopic : NSObject


/**
 *  帖子ID
 */
@property (nonatomic,copy) NSString * ID;

/**
 *  昵称
 */
@property (nonatomic,copy) NSString * name;
/**
 *  头像
 */
@property (nonatomic,copy) NSString * profile_image;
/**
 *  发帖时间
 */
@property (nonatomic,copy) NSString * create_time;
/**
 *  帖子正文
 */
@property (nonatomic,copy) NSString * text;
/**
 *  顶的人数
 */
@property (nonatomic,assign) NSInteger ding;
/**
 *  踩的人数
 */
@property (nonatomic,assign) NSInteger cai;
/**
 *  转发的人数
 */
@property (nonatomic,assign) NSInteger repost;
/**
 *  评论的人数
 */
@property (nonatomic,assign) NSInteger comment;
/**
 *  新浪认证
 */
@property (nonatomic,assign,getter=isSina_v) BOOL sina_v;

/**
 *  图片的宽度
 */
@property (nonatomic,assign) CGFloat width;
/**
 *  图片的高度
 */
@property (nonatomic,assign) CGFloat height;
/**
 *  小图片的URL
 */
@property (nonatomic,copy) NSString *smallImage;
/**
 *  中图片的URL
 */
@property (nonatomic,copy) NSString *middleImage;
/**
 *  大图片的URL
 */
@property (nonatomic,copy) NSString *bigImage;
/**
 *  帖子的类型
 */
@property (nonatomic,assign) YPTopicType  type;
/**
 *  该图片是否为大图
 */
@property (nonatomic,assign, getter=isBigPicture) BOOL bigPicture;
/**
 *  声音帖子的播放次数
 */
@property (nonatomic,assign) NSInteger playcount;
/**
 *  声音的时长
 */
@property (nonatomic,assign) NSInteger voicetime;
/**
 *  视频的时长
 */
@property (nonatomic,assign) NSInteger videotime;
/**
 *  热门评论
 */
@property (nonatomic,strong) YPComment *top_cmt;


/**
 *  额外的cell高度属性  避免在上下拉tableView时  反复计算cell的高度
 */

@property (nonatomic,assign ,readonly) CGFloat cellHeight;

/**
 *  图片类型帖子的图片frame
 */
@property (nonatomic,assign,readonly) CGRect pictureFrame;
/**
 *  当前图片的下载进度
 */
@property (nonatomic,assign) CGFloat pictureProgress;
/**
 *  声音类型帖子frame
 */
@property (nonatomic,assign,readonly) CGRect voiceFrame;
/**
 *  视频类型帖子frame
 */
@property (nonatomic,assign,readonly) CGRect videoFrame;

@end
