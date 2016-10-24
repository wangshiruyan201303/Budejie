//
//  YPCommentCell.h
//  百思不得姐
//
//  Created by yupeng on 16/9/28.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  YPComment;

@interface YPCommentCell : UITableViewCell

/**
 *  评论模型
 */
@property (nonatomic,strong) YPComment *comment;

@end
