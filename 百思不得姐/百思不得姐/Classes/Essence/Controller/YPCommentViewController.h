//
//  YPCommentViewController.h
//  百思不得姐
//
//  Created by yupeng on 16/9/27.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YPTopic;

@interface YPCommentViewController : UIViewController

/**
 *  话题模型
 */
@property (nonatomic,strong) YPTopic *topic;

@end
