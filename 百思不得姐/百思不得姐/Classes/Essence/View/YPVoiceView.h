//
//  YPVoiceView.h
//  百思不得姐
//
//  Created by yupeng on 16/8/24.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YPTopic;

@interface YPVoiceView : UIView

@property (nonatomic,strong) YPTopic * topic;

+(instancetype)voiceView;

@end
