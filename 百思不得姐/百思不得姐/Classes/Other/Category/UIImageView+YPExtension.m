//
//  UIImageView+YPExtension.m
//  百思不得姐
//
//  Created by yupeng on 16/10/3.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "UIImageView+YPExtension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (YPExtension)

-(void)setHeader:(NSString *)url{
    
    UIImage * placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.image = image ? [image  circleImage] : placeholder;
        
    }];
}

@end
