
#import <UIKit/UIKit.h>

typedef enum {
    YPTopicTypeAll = 1,
    YPTopicTypePicture = 10,
    YPTopicTypeWord = 29,
    YPTopicTypeVoice = 31,
    YPTopicTypeVideo = 41
} YPTopicType ;


/**
 *  头部标签高度
 */
UIKIT_EXTERN CGFloat const YPTitleViewH;
/**
 *  头部标签Y值
 */
UIKIT_EXTERN CGFloat const YPTitleViewY;
/**
 *  自定义cell的内边距
 */
UIKIT_EXTERN CGFloat const YPTopicCellMargin;
/**
 *  自定义cell的文字Y值
 */
UIKIT_EXTERN CGFloat const YPTopicCellTextY;
/**
 *  自定义cell的底部工具条高度
 */
UIKIT_EXTERN CGFloat const YPTopicCellBottomBarH;
/**
 *  规定图片最大的高度
 */
UIKIT_EXTERN CGFloat const YPTopicCellPictureMaxH;
/**
 *  当图片超过最大高度时，让imageView的高度等于一个定值
 */
UIKIT_EXTERN CGFloat const YPTopicCellPictureBeyondH;

/**
 *  XMGUser模型-性别属性值
 */
UIKIT_EXTERN NSString * const YPGUserSexMale;
UIKIT_EXTERN NSString * const YPUserSexFemale;

/**
 *  精华-cell-最热评论标题的高度
 */
UIKIT_EXTERN CGFloat const YPTopicCellTopCmtTitleH;

/**
 * tabBar被选中的通知名字
 */
UIKIT_EXTERN NSString * const YPTabBarDidSelectNotification;
/**
 * tabBar被选中的通知 被选中的控制器的index Key
 */
UIKIT_EXTERN NSString * const YPSelectedControllerIndexKey;
/**
 * tabBar被选中的通知 - 被选中的控制器key
 */
UIKIT_EXTERN NSString * const YPSelectedControllerKey;
/**
 *  自定义添加标签的内边距
 */
UIKIT_EXTERN CGFloat const YPAddTagMargin;








