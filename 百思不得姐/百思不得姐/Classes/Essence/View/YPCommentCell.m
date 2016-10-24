//
//  YPCommentCell.m
//  百思不得姐
//
//  Created by yupeng on 16/9/28.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPCommentCell.h"
#import "UIImageView+WebCache.h"
#import "YPComment.h"
#import "YPUser.h"

@interface YPCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@end



@implementation YPCommentCell

/**
 *  设置表格之间的分割线
 */
- (void)awakeFromNib {
    
    UIImageView * backGroundView = [[UIImageView alloc] init];
    backGroundView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = backGroundView;
    self.translatesAutoresizingMaskIntoConstraints = YES;
    
//    self.autoresizingMask = UIViewAutoresizingNone;
    
}

-(void)setComment:(YPComment *)comment{
    
    _comment = comment;
    
    [self.profileView setHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:YPGUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.nicknameLabel.text = comment.user.username;
    self.likeCount.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    self.commentLabel.text = comment.content;
    
    //判断音频评论按钮是否需要显示
    if (comment.voiceuri.length) {
        self.voiceBtn.hidden = NO;
        [self.voiceBtn setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    } else{
        self.voiceBtn.hidden = YES;
    }
}

-(void)setFrame:(CGRect)frame{
    
    
    frame.origin.x = YPTopicCellMargin;
    frame.size.width -= 2 * YPTopicCellMargin;
    
    [super setFrame:frame];
}

#pragma mark - 能成为第一响应者

-(BOOL)canBecomeFirstResponder{
    return YES;
}

/**
 * 能够响应哪些系统自带方法
 */
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    //return NO表示，不响应系统自带的方法，比如复制、粘贴、全选等
    return NO;
}

@end
