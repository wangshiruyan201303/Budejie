//
//  YPTopicCell.m
//  百思不得姐
//
//  Created by yupeng on 16/8/17.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPTopicCell.h"
#import "UIImageView+WebCache.h"
#import "YPTopic.h"
#import "YPPictureView.h"
#import "YPVoiceView.h"
#import "YPVideoView.h"
#import "YPComment.h"
#import "YPUser.h"


@interface YPTopicCell()

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

/**
 *  创建时间
 */
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;

/**
 *  顶的人数
 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;

/**
 *  踩的人数
 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

/**
 *  转发数
 */
@property (weak, nonatomic) IBOutlet UIButton *repostButton;

/**
 *  评论数
 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/**
 *  新浪认证
 */
@property (weak, nonatomic) IBOutlet UIImageView *sinaView;
/**
 *  内容正文
 */
@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;
/**
 *  最热评论父控件
 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/**
 *  评论内容
 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;


/**
 *  cell内部的显示picture的view
 */

@property (weak, nonatomic) YPPictureView *pictureImageView;
/**
 *  cell内部的显示voice的view
 */

@property (weak, nonatomic) YPVoiceView *voiceView;
/**
 *  cell内部的显示video的view
 */

@property (weak, nonatomic) YPVideoView *videoView;

@end


@implementation YPTopicCell

+(instancetype)cell{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:0] lastObject];
}

/**
 *  懒加载pictureImageView
 */
-(YPPictureView *)pictureImageView{
    
    if (!_pictureImageView) {
        
        YPPictureView *pictureImageView = [YPPictureView pictureView];
        
        //将展示图片的pictureImageView添加到cell的contentView上边 作为子控件
        [self.contentView addSubview:pictureImageView];
        
        _pictureImageView = pictureImageView;
    }
    
    return _pictureImageView;
}

/**
 *  懒加载voiceView
 */
-(YPVoiceView *)voiceView{
    
    if (!_voiceView) {
        
        YPVoiceView *voiceView = [YPVoiceView voiceView];
        
        //将展示声音的voiceView添加到cell的contentView上边 作为子控件
        [self.contentView addSubview:voiceView];
        
        _voiceView = voiceView;
        
    }
    return _voiceView;
}

/**
 *  懒加载videoView
 */

-(YPVideoView *)videoView{
    
    if (!_videoView) {
        
        YPVideoView *videoView = [YPVideoView videoView];
        
        //将展示声音的voiceView添加到cell的contentView上边 作为子控件
        [self.contentView addSubview:videoView];
        
        _videoView = videoView;
    }
    
    return _videoView;
}

- (void)awakeFromNib {
    
    UIImageView * backGroundView = [[UIImageView alloc] init];
    backGroundView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = backGroundView;
//    self.autoresizingMask = UIViewAutoresizingNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setTopic:(YPTopic *)topic{
    
    _topic = topic;
    
    //设置子控件数据

    [self.profileImageView setHeader:topic.profile_image];
    self.creatTimeLabel.text = topic.create_time;
    self.nickNameLabel.text = topic.name;
    
    //是否显示新浪认证
    
    self.sinaView.hidden = !topic.isSina_v;
    
    //设置下边按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    //设置cell的内容正文
    self.myTextLabel.text = topic.text;
    
    //根据帖子类型（类型）添加对应的内容到cell中间
    if (topic.type == YPTopicTypePicture) { //图片类型帖子
        
        self.pictureImageView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureImageView.topic = topic;
        self.pictureImageView.frame = topic.pictureFrame;
    } else if (topic.type == YPTopicTypeVoice){ //声音类型帖子
        
        self.voiceView.hidden = NO;
        self.pictureImageView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceFrame;
    }else if(topic.type == YPTopicTypeVideo){ //视频类型帖子
        
        self.videoView.hidden = NO;
        self.pictureImageView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoFrame;
    } else if(topic.type == YPTopicTypeWord){ //段子类型帖子
        
        self.pictureImageView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    
    //处理最热评论
    
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];
    } else{
        self.topCmtView.hidden = YES;
    }
    
    
}


-(void)setupButtonTitle:(UIButton *)button count:(NSInteger)count  placeholder:(NSString *)placeholder{
    
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    } else if (count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
    
}



/**
 *  调整cell的边框
 */
-(void)setFrame:(CGRect)frame{
    
   
    frame.origin.x = YPTopicCellMargin;
    frame.origin.y += YPTopicCellMargin;
    frame.size.height = self.topic.cellHeight - YPTopicCellMargin;
    frame.size.width -= 2 * YPTopicCellMargin;
    
    [super setFrame:frame];
}

/**
 *  cell右上角图片点击事件
 */
- (IBAction)showMore {
    
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
}


@end
