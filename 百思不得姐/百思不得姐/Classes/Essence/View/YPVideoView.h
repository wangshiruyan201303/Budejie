//
//  YPVideoView.h
//  百思不得姐
//
//  Created by yupeng on 16/8/25.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  YPTopic;


@interface YPVideoView : UIView

/**
 *  帖子数据
 */
@property (nonatomic,strong) YPTopic *topic;

+(instancetype)videoView;

@end
