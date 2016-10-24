//
//  YPCommentHeaderView.m
//  百思不得姐
//
//  Created by yupeng on 16/9/28.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPCommentHeaderView.h"

@interface YPCommentHeaderView()

/**
 *  文字标签
 */
@property (nonatomic,weak) UILabel * label;

@end


@implementation YPCommentHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = YPGlobalColor;
        
        //创建Label
        UILabel * label = [[UILabel alloc] init];
        label.textColor = YPRGBColor(67, 67, 67);
        label.width = YPScreenW - 2 * YPTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.x = YPTopicCellMargin;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

+(instancetype)headerViewWithTableView:(UITableView *)tableView{
    
    static NSString * headerID = @"header";
    YPCommentHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (headerView == nil) { //缓存池没有  需要创建
        headerView = [[YPCommentHeaderView alloc] initWithReuseIdentifier:headerID];
    }
    return headerView;
}

-(void)setTitle:(NSString *)title{
    _title = [title copy];
    self.label.text = title;
}

@end
