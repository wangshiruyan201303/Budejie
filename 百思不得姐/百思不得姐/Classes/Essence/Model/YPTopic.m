//
//  YPTopic.m
//  百思不得姐
//
//  Created by yupeng on 16/8/17.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPTopic.h"
#import "MJExtension.h"
#import "YPUser.h"
#import "YPComment.h"

@implementation YPTopic

{
    CGFloat _cellHeight;
    CGRect _pictureFrame;
}

/**
 *  替换属性名用以和服务器返回字段保持一致
 */

+(NSDictionary *)mj_replacedKeyFromPropertyName{
 
    return @{
             @"smallImage" : @"image0",
             @"bigImage" : @"image1",
             @"middleImage" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
    
}

/**
 *  告诉MJExtension 数组top_cmt 里边存储评论模型
 */

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"top_cmt" : @"YPComment"};
    
}


/**
 *  重写_create_time属性的get方法
 */
- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}


-(CGFloat)cellHeight{
       
    
    if (!_cellHeight) {
        
        //文字最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * YPTopicCellMargin, MAXFLOAT);
        
        //计算文字高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //cell的高度
        //文字和它之前的高度
        _cellHeight = YPTopicCellTextY + textH + YPTopicCellMargin ;
        
        //根据帖子类型来计算cell的内容高度
        if (self.type == YPTopicTypePicture) { //如果帖子类型是图片
            
            //设置图片显示的宽度
            CGFloat pictureW = maxSize.width;
            //设置显示图片的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            
            //判断计算出来的图片frame的高度是否超过了设定值
            if (pictureH >= YPTopicCellPictureMaxH) {
                pictureH = YPTopicCellPictureBeyondH;
                self.bigPicture = YES;
            }
            //图片x值
            CGFloat pictureX = YPTopicCellMargin;
            //图片Y值
            CGFloat pictureY = YPTopicCellTextY + textH + YPTopicCellMargin;
            
            //图片frame
            _pictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            
            //根据图片来增加cell高度
            _cellHeight += pictureH + YPTopicCellMargin;
            
        } else if(self.type == YPTopicTypeVoice){ //如果帖子类型是声音
            
            //设置声音帖子图片显示宽度
            CGFloat voiceW = maxSize.width;
            CGFloat voiceX = YPTopicCellMargin;
            CGFloat voiceY = YPTopicCellTextY + textH + YPTopicCellMargin;
            CGFloat voiceH = voiceW * self.height / self.width;
            
            //声音控件frame
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            //根据声音控件计算cell高度
            _cellHeight += voiceH + YPTopicCellMargin;
            
        } else if(self.type == YPTopicTypeVideo){ //如果帖子类型是声音
            
            //设置声音帖子图片显示宽度
            CGFloat videoW = maxSize.width;
            CGFloat videoX = YPTopicCellMargin;
            CGFloat videoY = YPTopicCellTextY + textH + YPTopicCellMargin;
            CGFloat videoH = videoW * self.height / self.width;
            
            //声音控件frame
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            //根据声音控件计算cell高度
            _cellHeight += videoH + YPTopicCellMargin;
            
                
            }
        
        //如果有最热评论
        if (self.top_cmt) {
            
            NSString *content = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
            
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            //增加热门评论高度
            _cellHeight += contentH + YPTopicCellTopCmtTitleH + YPTopicCellMargin;
            
        }
        
        //根据底部工具条增加cell的高度
        _cellHeight += YPTopicCellBottomBarH + YPTopicCellMargin;
    }
    
    
    return _cellHeight;
}

@end
