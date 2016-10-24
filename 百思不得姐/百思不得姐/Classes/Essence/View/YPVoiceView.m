//
//  YPVoiceView.m
//  百思不得姐
//
//  Created by yupeng on 16/8/24.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPVoiceView.h"
#import "YPTopic.h"
#import "UIImageView+WebCache.h"
#import "YPShowPictureViewController.h"

@interface YPVoiceView()
/**
 *  声音的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**
*  播放次数
*/
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

/**
*  声音时长
*/
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end

@implementation YPVoiceView

-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //设置myImageView可以与用户交互 并添加监听
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

+(instancetype)voiceView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}



/**
 *  为子控件设置模型
 */
-(void)setTopic:(YPTopic *)topic{
    
    _topic = topic;
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage]];
    
    //设置播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    //设置声音时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
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
