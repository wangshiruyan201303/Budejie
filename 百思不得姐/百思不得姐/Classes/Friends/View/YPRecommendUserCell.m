//
//  YPRecommendUserCell.m
//  百思不得姐
//
//  Created by yupeng on 16/8/10.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPRecommendUserCell.h"
#import "YPRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface YPRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screen_NameView;

@property (weak, nonatomic) IBOutlet UILabel *fans_CountView;


@end

@implementation YPRecommendUserCell

-(void)setUser:(YPRecommendUser *)user{
    
    _user = user;
    
    self.screen_NameView.text = user.screen_name;
    NSString * fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人订阅",user.fans_count];
    }else{ //订阅人数大于1万
        
        fansCount = [NSString stringWithFormat:@"%.1f万人订阅",user.fans_count / 10000.0];
        
    }
    self.fans_CountView.text = fansCount;
//    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.headerImageView setHeader:user.header];
    
}


@end
