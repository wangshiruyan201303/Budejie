//
//  YPRecommendCategoryCell.m
//  百思不得姐
//
//  Created by yupeng on 16/8/9.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPRecommendCategoryCell.h"
#import "YPRecommendCategory.h"

@interface YPRecommendCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *indicatorView;


@end

@implementation YPRecommendCategoryCell

- (void)awakeFromNib {
    
    self.backgroundColor = YPRGBColor(244, 244, 244);
    self.indicatorView.backgroundColor = YPRGBColor(219, 21, 26);
    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    //设置显示器视图的显示或者隐藏
    self.indicatorView.hidden = !selected;
    //设置cell内的文字颜色
    self.textLabel.textColor = selected ? self.indicatorView.backgroundColor : YPRGBColor(78, 78, 78);
    
}

-(void)setCategory:(YPRecommendCategory *)category{
    
    _category = category;
    self.textLabel.text = category.name;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //重新调整内部控件尺寸，防止挡住底部分割线
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
    
}

@end
