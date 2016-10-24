//
//  YPPictureView.m
//  百思不得姐
//
//  Created by yupeng on 16/8/19.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPPictureView.h"
#import "YPTopic.h"
#import "UIImageView+WebCache.h"
#import "YPProgressView.h"
#import "YPShowPictureViewController.h"

@interface YPPictureView()
/**
 *  显示图片类型帖子的图片视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
/**
 *  Gif图片的标识
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
/**
 *  点击查看大图
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/**
 *  进度条控件
 */
@property (weak, nonatomic) IBOutlet YPProgressView *progressView;

@end

@implementation YPPictureView

/**
 *  设置autoResizingMask 防止自定义的控件frame被拉伸
 */

-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //设置myImageView可以与用户交互 并添加监听
    self.myImageView.userInteractionEnabled = YES;
    [self.myImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

+(instancetype)pictureView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


-(void)setTopic:(YPTopic *)topic{
    
    _topic = topic;
    
    //首先应立即显示当前图片的下载进度（防止因为网速慢导致现实的是其他cell中图片的下载进度）
    
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    //设置cell的图片
//    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage ]];
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        
        //是指当前cell图片的下载进度
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        
        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
        //如果是大图 为让imageView显示图片最顶部内容 进行绘图操作
        if (topic.isBigPicture == NO) return ;
        
        //开启图行上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureFrame.size, YES, 0.0);
        
        //将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureFrame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        //获得图片
        self.myImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //结束图形上下文
        UIGraphicsEndImageContext()
        ;
    }];
    
    //根据图片url的扩展名判断该图片是否为GIF
    NSString *extension = topic.bigImage.pathExtension;
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    //判断是否需要隐藏“点击查看大图按钮”
    if (topic.isBigPicture) { //大图
        //隐藏查看大图按钮
        self.seeBigButton.hidden = NO;
//        self.myImageView.contentMode = UIViewContentModeScaleAspectFill;
    } else{ // 非大图
        self.seeBigButton.hidden = YES;
//        self.myImageView.contentMode = UIViewContentModeScaleToFill;
    }
}

#pragma mark - 点击cell的图片 显示大图
/**
 *  展示大图
 */
-(void)showPicture{
    
    YPShowPictureViewController *showPicture = [[YPShowPictureViewController alloc] init];
    
    showPicture.topic = self.topic;
    
    //当在一个View中 使用present方法时，可以考虑先拿到当前的跟控制器 调用跟控制器的方法来推出新的控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
    
    
}


@end
