//
//  YPPictureView.h
//  百思不得姐
//
//  Created by yupeng on 16/8/19.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YPTopic;

@interface YPPictureView : UIView

/**
 *  引入topic模型 用于接收该模型中的frame属性
 *  以及用相关属性设置子控件数据
 */
@property (nonatomic,strong) YPTopic *topic;


+(instancetype)pictureView;

@end
