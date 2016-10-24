//
//  YPRecommendTagCell.m
//  百思不得姐
//
//  Created by yupeng on 16/8/11.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPRecommendTagCell.h"
#import "YPRecommendTag.h"
#import "UIImageView+WebCache.h"

@interface YPRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;

@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation YPRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setRecommendTag:(YPRecommendTag *)recommendTag{
    
    _recommendTag = recommendTag;
//    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.imageListView setHeader:recommendTag.image_list];
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString * subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{ //订阅人数大于1万
        
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 10000.0];
        
    }
    self.subNumberLabel.text = subNumber;
}
/**
 *  修改cell的frame属性，可以达到永久更改的效果 这也是给cell添加分割线的方式之一
 *  此方法不需要添加新的UIView作为分割线
 */
-(void)setFrame:(CGRect)frame{
    
    frame.origin.x = 7;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -=1;
    [super setFrame:frame];
}

@end
