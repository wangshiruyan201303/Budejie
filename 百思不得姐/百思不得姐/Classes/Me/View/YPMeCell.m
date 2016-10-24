//
//  YPMeCell.m
//  百思不得姐
//
//  Created by yupeng on 16/10/4.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPMeCell.h"

@implementation YPMeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //设置cell背景图片
        UIImageView * backGroundView = [[UIImageView alloc] init];
        backGroundView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = backGroundView;
        
        //右边指示器样式
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // label文字颜色和字体
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = [UIColor blackColor];
        
        //设置cell选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.imageView.image == nil) {
        
        return;
    }
    
    //设置imageView的尺寸
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + YPTopicCellMargin;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
