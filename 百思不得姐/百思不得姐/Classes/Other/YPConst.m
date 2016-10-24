
#import <UIKit/UIKit.h>

CGFloat const YPTitleViewH = 35;
CGFloat const YPTitleViewY = 64;
/**
 *  自定义cell的内边距
 */
CGFloat const YPTopicCellMargin = 10;
/**
 *  自定义cell的文字Y值
 */
CGFloat const YPTopicCellTextY = 55;
/**
 *  自定义cell的底部工具条高度
 */
CGFloat const YPTopicCellBottomBarH = 44;
/**
 *  规定图片最大的高度
 */
CGFloat const YPTopicCellPictureMaxH = 1000;
/**
 *  当图片超过最大高度时，让imageView的高度等于一个定值
 */
CGFloat const YPTopicCellPictureBeyondH = 250;
/**
 *  男
 */
NSString * const YPGUserSexMale = @"m";
/**
 *  女
 */
NSString * const YPGUserSexFemale = @"f";

CGFloat const YPTopicCellTopCmtTitleH = 20;

/**
 *  自定义添加标签的内边距
 */
CGFloat const YPAddTagMargin = 5;

/**
 * tabBar被选中的通知名字
 */
 NSString * const YPTabBarDidSelectNotification = @"YPTabBarDidSelectNotification";
/**
 * tabBar被选中的通知 被选中的控制器的index Key
 */
 NSString * const YPSelectedControllerIndexKey = @"YPSelectedControllerIndexKey";
/**
 * tabBar被选中的通知 - 被选中的控制器key
 */
 NSString * const YPSelectedControllerKey = @"YPSelectedControllerKey";