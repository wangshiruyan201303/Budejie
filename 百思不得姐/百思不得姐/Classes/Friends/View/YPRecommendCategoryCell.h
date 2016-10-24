//
//  YPRecommendCategoryCell.h
//  百思不得姐
//
//  Created by yupeng on 16/8/9.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  YPRecommendCategory;

@interface YPRecommendCategoryCell : UITableViewCell

/**
 *  接受数据的模型
 */
@property (nonatomic,strong) YPRecommendCategory * category;

@end
