//
//  YPTopicCell.h
//  百思不得姐
//
//  Created by yupeng on 16/8/17.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  YPTopic;

@interface YPTopicCell : UITableViewCell


@property (nonatomic,strong) YPTopic *topic;

+(instancetype)cell;

@end
