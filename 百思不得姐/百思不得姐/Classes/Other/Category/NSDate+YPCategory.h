//
//  NSDate+YPCategory.h
//  百思不得姐
//
//  Created by yupeng on 16/8/18.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YPCategory)

/**
 *  比较当前时间与from的差值
 */

-(NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 *  是否是今年
 */
-(BOOL)isThisYear;
/**
 *  是否是今天
 */
-(BOOL)isToday;

/**
 *  是否是昨天
 */
-(BOOL)isYesterday;

@end
