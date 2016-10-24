//
//  YPCommentHeaderView.h
//  百思不得姐
//
//  Created by yupeng on 16/9/28.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPCommentHeaderView : UITableViewHeaderFooterView

/**
 *  headerView的标题
 */
@property (nonatomic,copy) NSString * title;


+(instancetype)headerViewWithTableView:(UITableView *)tableView;


@end
